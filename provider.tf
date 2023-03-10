# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }
terraform {
  required_version = ">= 0.12"
}

# Configure and downloading plugins for aws
provider "aws" {
  region     = "${var.aws_region}"
}
