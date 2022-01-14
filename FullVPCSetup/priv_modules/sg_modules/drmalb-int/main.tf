resource "aws_security_group" "drmalb-int" {
  name        = "drmalb-int-${var.vpc_name}"
  description = "drmalb-int - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "drmalb-int-${var.vpc_name}"
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "all ipv4"
    cidr_blocks = [
    "0.0.0.0/0"]
    ipv6_cidr_blocks = [
    "::/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "all ipv6"
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