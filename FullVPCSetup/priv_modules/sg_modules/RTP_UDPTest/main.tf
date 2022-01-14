resource "aws_security_group" "RTP_UDPTest" {
  name        = "RTP_UDPTest"
  description = "RTP_UDPTest - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "RTP_UDPTest"
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "sshproxy group"
    cidr_blocks = var.sandyofficeandlab
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    description = "ICMP"
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