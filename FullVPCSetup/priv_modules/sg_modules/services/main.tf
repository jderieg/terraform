resource "aws_security_group" "services" {
  name        = "services-${var.vpc_name}"
  description = "services - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "services-${var.vpc_name}"
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
    description = "services group"
    self        = true
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    description = "ping from Oregon"
    cidr_blocks = ["172.31.0.0/16"]
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