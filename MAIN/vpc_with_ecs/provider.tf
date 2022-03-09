terraform {
  /*
  cloud {
    organization = "example_corp"

    workspaces {
      tags = ["app"]
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
