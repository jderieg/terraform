##### Create ecs cluster
resource "aws_ecs_cluster" "aws-ecs" {
  name = var.app_name
}

##### IAM Setup
data "aws_iam_policy_document" "instance-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ecsInstanceRole" {
  name = "${var.app_name}-ecsInstanceRole"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role.json
}
resource "aws_iam_role_policy_attachment" "ecsInstanceRole" {
  role = aws_iam_role.ecsInstanceRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}
resource "aws_iam_instance_profile" "ecsInstanceRole" {
  name = "${var.app_name}-ecsInstanceRole"
  role = aws_iam_role.ecsInstanceRole.name
}
data "aws_iam_policy_document" "task-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ecsTaskExecutionRole" {
  name = "${var.app_name}-ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.task-assume-role.json
}
resource "aws_iam_role_policy_attachment" "ecsTaskExecutionRole" {
  role = aws_iam_role.ecsTaskExecutionRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

##### Container Template
data "template_file" "docker_app" {
  template = file("./docker.json")
  vars = {
    app_name = var.docker_app_name
    app_image = var.docker_app_image
    app_port = var.docker_app_port
    fargate_cpu = var.docker_fargate_cpu
    fargate_memory = var.docker_fargate_memory
    aws_region = var.region
  }
}

##### ECS task definition
resource "aws_ecs_task_definition" "docker_app" {
  family = "docker-task"
  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
  network_mode = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu = var.docker_fargate_cpu
  memory = var.docker_fargate_memory
  container_definitions = data.template_file.docker_app.rendered
}

##### ECS Service
resource "aws_ecs_service" "docker_app" {
  name = var.docker_app_name
  cluster = aws_ecs_cluster.aws-ecs.id
  task_definition = aws_ecs_task_definition.docker_app.arn
  desired_count = var.docker_app_count
  launch_type = "FARGATE"
  network_configuration {
    security_groups = [aws_security_group.aws-ecs-tasks.id]
    subnets = module.new_vpc.public_subnets
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_alb_target_group.docker_app.id
    container_name = var.docker_app_name
    container_port = var.docker_app_port
  }
  depends_on = [aws_alb_listener.front_end]
  tags = {
    Name = "${var.docker_app_name}-docker-ecs"
  }
}

##### Security
# ALB Security Group: Edit to restrict access to the application
resource "aws_security_group" "aws-lb" {
  name = "${var.docker_app_name}-load-balancer"
  description = "Controls access to the ALB"
  vpc_id = module.new_vpc.vpc_id
  ingress {
    protocol = "tcp"
    from_port = var.docker_app_port
    to_port = var.docker_app_port
    cidr_blocks = var.app_sources_cidr
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.docker_app_name}-load-balancer"
  }
}
# Traffic to the ECS cluster from the ALB
resource "aws_security_group" "aws-ecs-tasks" {
  name = "${var.docker_app_name}-ecs-tasks"
  description = "Allow inbound access from the ALB only"
  vpc_id = module.new_vpc.vpc_id
  ingress {
    protocol = "tcp"
    from_port = var.docker_app_port
    to_port = var.docker_app_port
    security_groups = [aws_security_group.aws-lb.id]
  }
  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.docker_app_name}-ecs-tasks"
  }
}

##### ALB Setup
resource "aws_alb" "main" {
  name = "${var.docker_app_name}-load-balancer"
  subnets = module.new_vpc.public_subnets
  security_groups = [aws_security_group.aws-lb.id]
  tags = {
    Name = "${var.app_name}-alb"
  }
}
resource "aws_alb_target_group" "docker_app" {
  name = "${var.docker_app_name}-target-group"
  port = var.docker_app_port
  protocol = "HTTP"
  vpc_id = module.new_vpc.vpc_id
  target_type = "ip"
  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "3"
    path = "/"
    unhealthy_threshold = "2"
  }
  tags = {
    Name = "${var.docker_app_name}-alb-target-group"
  }
}
# Redirect all traffic from the ALB to the target group
resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.main.id
  port = var.docker_app_port
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.docker_app.id
    type = "forward"
  }
}
# output docker public ip
output "docker_dns_lb" {
  description = "DNS load balancer"
  value = aws_alb.main.dns_name
}