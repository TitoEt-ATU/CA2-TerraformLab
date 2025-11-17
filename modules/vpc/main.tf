#from terraform module tutorial, key components
provider "aws" {
  region = "eu-west-1"
}

resource "aws_eip" "nat" {
  count = 3
  domain = "vpc"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  single_nat_gateway  = false
  reuse_nat_ips = true                   
  external_nat_ip_ids = "${aws_eip.nat.*.id}" 
  create_vpc = false
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  create_database_internet_gateway_route = true
  enable_public_redshift = true

  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

