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

module "demo" {
  source = "../modules/aws-networking-demo/"
  vpc_name = "demo_vpc"
  vpc_cidr_block = "10.100.0.0/16"
  vpc_instance_tenancy = "default"
}
