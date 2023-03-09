terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure and downloading plugins for aws
provider "aws" {
  region     = "${var.aws_region}"
}
