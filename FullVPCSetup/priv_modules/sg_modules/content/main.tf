resource "aws_security_group" "content" {
  name        = "content-${var.vpc_name}"
  description = "content - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "content-${var.vpc_name}"
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
    from_port   = 7999
    to_port     = 8000
    protocol    = "tcp"
    description = "elb group"
    security_groups = [
    var.elb_id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "content group"
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