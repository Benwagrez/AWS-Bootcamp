terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = var.region

  default_tags {
    tags = var.default_tags
  }
}

module "networking" {
  source = "./Networking"
  region = var.region # Sending parent variable to child module
}
