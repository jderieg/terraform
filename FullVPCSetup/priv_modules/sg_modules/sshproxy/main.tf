resource "aws_security_group" "sshproxy" {
  name        = "sshproxy-${var.vpc_name}"
  description = "sshproxy - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "sshproxy-${var.vpc_name}"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "all vpn endpoints"
    security_groups = [
    var.corp-vpns_id]
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