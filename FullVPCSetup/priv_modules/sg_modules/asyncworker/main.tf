resource "aws_security_group" "asyncworker" {
  name        = "asyncworker-${var.vpc_name}"
  description = "asyncworker - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "asyncworker-${var.vpc_name}"
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
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "asyncworker group"
    self        = true
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    description = "ICMP"
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