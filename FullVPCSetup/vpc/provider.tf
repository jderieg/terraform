terraform {
  required_providers {
    aws = {
      version = ">= 3.63"
    }
  }
}

provider "aws" {
  region = var.region
  profile = "mf_dev"
}