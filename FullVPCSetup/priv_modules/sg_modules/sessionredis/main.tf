resource "aws_security_group" "sessionredis" {
  name        = "sessionsredis-${var.vpc_name}"
  description = "sessionsredis - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "sessionsredis-${var.vpc_name}"
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    description = "services group"
    security_groups = [
    var.services_id]
  }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    description = "chimera group"
    security_groups = [
    var.chimera_id]
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "content group"
    security_groups = [
    var.content_id]
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
