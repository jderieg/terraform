resource "aws_security_group" "adproxy" {
  name        = "adproxy-${var.vpc_name}"
  description = "adproxy - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "adproxy-${var.vpc_name}"
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
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    description = "allows adproxy alb to connect"
    security_groups = [
    var.adproxyalb_id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "adproxy group"
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