resource "aws_security_group" "azurevpn" {
  name        = "azurevpn-${var.vpc_name}"
  description = "azurevpn - managed by Terraform"
  vpc_id      = var.vpc_id

  tags = {
    Name = "azurevpn-${var.vpc_name}"
  }

  ingress {
    from_port   = 2222
    to_port     = 2222
    protocol    = "tcp"
    description = "VPN Endpoints"
    cidr_blocks = var.vpn_endpoints
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "this region"
    cidr_blocks = [
    var.vpc_subnet]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "VPN endpoints"
    cidr_blocks = var.vpn_endpoints
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "VPN endpoints"
    cidr_blocks = var.vpn_endpoints
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