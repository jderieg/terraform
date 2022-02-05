terraform {
  /*
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "mellowfox"
    workspaces {
      name = "terraform"
    }
  }
  */
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      version = ">= 3.63"
    }
  }
}

provider "aws" {
  region = var.region
  profile = var.aws_profile
}
