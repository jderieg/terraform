resource "aws_security_group" "chimera" {
  name        = "chimera-${var.vpc_name}"
  description = "chimera box sg - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "chimera-${var.vpc_name}"
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
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    description = "from ALB"
    security_groups = [
    var.elb_id]
  }

  ingress {
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    description = "corp-vpns"
    security_groups = [
    var.corp-vpns_id]
  }

  ingress {
    from_port   = 6397
    protocol    = "tcp"
    to_port     = 6397
    description = "chimera group"
    self        = true
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