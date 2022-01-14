resource "aws_security_group" "adproxyredis" {
  name        = "adproxyredis-${var.vpc_name}"
  description = "adproxyredis - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "adproxyredis-${var.vpc_name}"
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    description = "adproxy group"
    security_groups = [
    var.adproxy_id]
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