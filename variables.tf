# Defining Region
variable "aws_region" {
  default = "ap-south-1"
}

# Defining CIDR Block for VPC
# Showing demo
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "imageUri" {
  default = "879580385544.dkr.ecr.ap-south-1.amazonaws.com/jenkins-ecr:latest"
}
