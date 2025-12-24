terraform {
  required_version = "~> 1.14.3"

  backend "s3" {
    key    = "strip-image-metadata.tfstate"
    region = var.region
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.27.0"
    }
  }
}

provider "aws" {
  region = var.region
}
