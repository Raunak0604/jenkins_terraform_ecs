terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure and downloading plugins for aws
provider "aws" {
  region     = "${var.aws_region}"
}
