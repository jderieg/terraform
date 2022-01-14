resource "aws_security_group" "wdrm" {
  name        = "wdrm-${var.vpc_name}"
  description = "wdrm - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "wdrm-${var.vpc_name}"
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "wdrm group"
    self        = true
  }

  ingress {
    from_port = 7999
    to_port   = 8000
    protocol  = "tcp"
    security_groups = [
    var.drmalb-int_id]
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