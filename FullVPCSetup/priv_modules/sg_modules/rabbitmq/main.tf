resource "aws_security_group" "rabbitmq" {
  name        = "rabbitmq-${var.vpc_name}"
  description = "rabbitmq - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "rabbitmq-${var.vpc_name}"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "sshproxy group"
    security_groups = [
    var.sshproxy_id]
  }

  ingress {
    from_port   = 5672
    to_port     = 5672
    protocol    = "tcp"
    description = "postgres port"
    security_groups = [
      var.asyncworker_id,
      var.logmunch_id,
    var.services_id]
  }

  ingress {
    from_port   = 5671
    to_port     = 5671
    protocol    = "tcp"
    description = "all ipv4"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "rabbitmq group"
    self        = true
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "0.0.0.0/0"]
    ipv6_cidr_blocks = [
    "::/0"]
  }
}