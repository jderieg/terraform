resource "aws_security_group" "adproxyalb" {
  name        = "adproxyalb-${var.vpc_name}"
  description = "adproxyalb - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "adproxyalb-${var.vpc_name}"
  }

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "adproxy for all"
  }

  ingress {
    from_port = 443
    protocol = "tcp"
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description = "adproxy for all "
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