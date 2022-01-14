resource "aws_security_group" "corpvpns-sshmongo" {
  name        = "corpvpns-sshmongo"
  description = "corp vpns - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "corpvpns-sshmongo"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Sunnyvale"
    cidr_blocks = var.sunnyvalevpns
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Nebraska"
    cidr_blocks = var.nebraskavpns
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Buffalo"
    cidr_blocks = var.buffalovpns
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Ireland"
    cidr_blocks = var.irelandvpns
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Edgecast VPN"
    cidr_blocks = var.edgecastvpns
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Sandy"
    cidr_blocks = var.sandynet
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "Other Builders"
    cidr_blocks = var.otherbuilders
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Sunnyvale"
    cidr_blocks = var.sunnyvalevpns
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Nebraska"
    cidr_blocks = var.nebraskavpns
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Buffalo"
    cidr_blocks = var.buffalovpns
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Ireland"
    cidr_blocks = var.irelandvpns
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Edgecast VPN"
    cidr_blocks = var.edgecastvpns
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Sandy"
    cidr_blocks = var.sandynet
  }

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    description = "Other Builders"
    cidr_blocks = var.otherbuilders
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