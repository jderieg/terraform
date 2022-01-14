resource "aws_security_group" "corp-vpns" {
  name        = "corp-vpns-${var.vpc_name}"
  description = "corp-vpns - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "corp-vpns-${var.vpc_name}"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "corp vpn endpoints"
    cidr_blocks = var.vpn_endpoints
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "builders vpn endpoints"
    cidr_blocks = var.builders_endpoints
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Sandy office external address"
    cidr_blocks = var.sandyofficeandlab
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "corp vpn endpoints"
    cidr_blocks = var.vpn_endpoints
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "builders vpn endpoints"
    cidr_blocks = var.builders_endpoints
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "Sandy office external address"
    cidr_blocks = var.sandyofficeandlab
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "corp vpn endpoints"
    cidr_blocks = var.vpn_endpoints
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "builders vpn endpoints"
    cidr_blocks = var.builders_endpoints
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "Sandy office external address"
    cidr_blocks = var.sandyofficeandlab
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "corp vpn endpoints"
    cidr_blocks = var.vpn_endpoints
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "builders vpn endpoints"
    cidr_blocks = var.builders_endpoints
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Sandy office external address"
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