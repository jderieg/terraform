resource "aws_security_group" "mongointernal" {
  name        = "mongointernal-${var.vpc_name}"
  description = "mongointernal - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "mongointernal-${var.vpc_name}"
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
    from_port   = 4949
    to_port     = 4949
    protocol    = "tcp"
    description = "mongomanager port"
    cidr_blocks = var.all_cidrs
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "downlynk regions"
    cidr_blocks = var.all_cidrs
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "ATLAS Peers"
    cidr_blocks = var.atlaspeers
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "build nodes from UL"
    cidr_blocks = var.ULOregon_natgws
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Sandy office external address"
    cidr_blocks = var.sandyofficeandlab
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Azure client"
    cidr_blocks = var.azure_subnets
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    description = "ICMP"
    cidr_blocks = var.all_cidrs
  }

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    description = "Atlas Endpoint"
    cidr_blocks = var.azure_subnets
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