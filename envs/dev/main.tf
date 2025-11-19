provider "aws" {
  region = "eu-west-1"
}

data "aws_availability_zones" "available" {}

module "vpc" {
  source = "/Users/titoetimiri/Lab2 Terraform/CA2-TerraformLab/modules/vpc"

  name            = "L00203089"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.20.0/24"]
  azs             = data.aws_availability_zones.available.names

  tags = {
    Owner = "Tito L00203089"
    Project = "CA2 Terraform Lab"
  }
}
