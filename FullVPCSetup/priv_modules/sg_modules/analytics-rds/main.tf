resource "aws_security_group" "analytics-rds" {
  name        = "analytics-rds-${var.vpc_name}"
  description = "analytics-rds - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "analytics-rds-${var.vpc_name}"
  }

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    description = "postgres port"
    security_groups = [
      var.celeryworker_id,
    var.services_id]
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