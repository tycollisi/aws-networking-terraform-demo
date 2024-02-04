variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type = string
}

variable "vpc_instance_tenancy" {
  description = "A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee."
  type = string
}

variable "vpc_name" {
  description = "Name assigned to the VPC"
  type = string
}
