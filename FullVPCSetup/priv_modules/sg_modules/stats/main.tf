resource "aws_security_group" "stats" {
  name        = "stats-${var.vpc_name}"
  description = "stats - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "stats-${var.vpc_name}"
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
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    description = "stats group"
    self        = true
  }

  ingress {
    from_port   = 16379
    to_port     = 16379
    protocol    = "tcp"
    description = "stats group"
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