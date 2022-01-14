resource "aws_security_group" "salt" {
  name        = "salt-${var.vpc_name}"
  description = "salt - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "salt-${var.vpc_name}"
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
    from_port   = 4505
    to_port     = 4506
    protocol    = "tcp"
    description = "regional cidr"
    cidr_blocks = [
    var.regional_cidr]
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