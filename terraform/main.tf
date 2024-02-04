provider "aws" {
  region  = "us-east-1" 
  profile = "tcollisi"
  default_tags {
    tags = {
      environment     = var.environment
      owner           = "tyler_collisi"
      deployment_type = "manual_terraform"
    }
  }
}

terraform {
  required_version = "1.7.1"

  backend "s3" {
    bucket = "ty-terraform-backend"
    key    = "aws-networking-terraform-demo/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table       = "ty-terraform-statelock"
    workspace_key_prefix = "terraform-state"
  }
}

// Note to self: Look into terraforms cidrsubnet() function: https://developer.hashicorp.com/terraform/language/functions/cidrsubnet
module "demo" {
  source = "../modules/aws-networking-demo/"
  vpc_name = "demo_vpc"
  vpc_cidr_block = "10.100.0.0/16"
  vpc_instance_tenancy = "default"
  igw_name = "demo_igw"
  subnet_name = "demo_public_a"
  subnet_cidr_block = "10.100.0.0/24"
  availability_zone = var.az_us_east_1["a"] 
  map_public_ip_on_launch = true
  route_table_name = "demo_public_route_table"
}

data aws_availability_zone "us-east-1a" {
  name = "us-east-1a"
}
