resource "aws_security_group" "office" {
  name        = "office-${var.vpc_name}"
  description = "sandy office access - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "office-${var.vpc_name}"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "sandy office"
    cidr_blocks = var.sandyofficeandlab
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "sandy office"
    cidr_blocks = var.sandyofficeandlab
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