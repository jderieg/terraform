resource "aws_security_group" "mongomanager" {
  name        = "mongomanager-${var.vpc_name}"
  description = "mongomanager - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "mongomanager-${var.vpc_name}"
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
    to_port     = 65535
    protocol    = "tcp"
    description = "mongomanager group"
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