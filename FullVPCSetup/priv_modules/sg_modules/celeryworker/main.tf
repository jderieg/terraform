resource "aws_security_group" "celeryworker" {
  name        = "celeryworker-${var.vpc_name}"
  description = "celeryworker - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "celeryworker-${var.vpc_name}"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "sshproxy group"
    security_groups = [
    var.sshproxy_id]
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