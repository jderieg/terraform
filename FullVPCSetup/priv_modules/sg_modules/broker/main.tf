resource "aws_security_group" "broker" {
  name        = "broker-${var.vpc_name}"
  description = "broker - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "broker-${var.vpc_name}"
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
    description = "all ipv4"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port   = 41791
    to_port     = 41791
    protocol    = "tcp"
    description = "all ipv4"
    cidr_blocks = [
    "0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    description = "Allow ICMP from Lab"
    cidr_blocks = [
    "184.165.8.197/32"]
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