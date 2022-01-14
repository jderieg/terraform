resource "aws_security_group" "liveslicer" {
  name        = "liveslicer-${var.vpc_name}"
  description = "liveslicer - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "liveslicer-${var.vpc_name}"
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
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "all internet"
    cidr_blocks = [
    "0.0.0.0/0"]
    ipv6_cidr_blocks = [
    "::/0"]
  }

  ingress {
    from_port   = 65009
    to_port     = 65020
    protocol    = "tcp"
    description = "all internet"
    cidr_blocks = [
    "0.0.0.0/0"]
    ipv6_cidr_blocks = [
    "::/0"]
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