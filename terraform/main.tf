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

resource "aws_vpc" "main" {
  cidr_block       = "10.100.0.0/16" 
  instance_tenancy = "default" 

  tags = {
    Name = "demo_vpc" 
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id 

  tags = {
    Name = "demo_igw" 
  }
}

resource "aws_eip" "eip" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = module.demo.public_subnet_ids[0]  

  tags = {
    Name = "demo_NAT_gateway" 
  }

  depends_on = [ aws_internet_gateway.gw ]

}

// Note to self: Look into terraforms cidrsubnet() function: https://developer.hashicorp.com/terraform/language/functions/cidrsubnet
module "demo" {
  source = "../modules/aws-networking-demo/"
  vpc_id = aws_vpc.main.id
  igw_id = aws_internet_gateway.gw.id
  public_subnets = [ 
  {
    name = "demo_public_a"
    cidr_block = "10.100.0.0/24"
    availability_zone = var.az_us_east_1["a"]
    map_public_ip_on_launch = true
  }
]
  private_subnets = [ 
  {
    name = "demo_private_a"
    cidr_block = "10.100.1.0/24"
    availability_zone = var.az_us_east_1["a"]
    map_public_ip_on_launch = false 
  }
]
  public_route_table_name = "demo_public_route_table"
  private_route_table_name = "demo_private_route_table"
  nat_gateway_id = aws_nat_gateway.gw.id 
}

data aws_availability_zone "us-east-1a" {
  name = "us-east-1a"
}
