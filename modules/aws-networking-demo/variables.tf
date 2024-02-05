//variable "vpc_cidr_block" {
//  description = "The IPv4 CIDR block for the VPC."
//  type = string
//}
//
//variable "vpc_instance_tenancy" {
//  description = "A tenancy option for instances launched into the VPC. Default is default, which ensures that EC2 instances launched in this VPC use the EC2 instance tenancy attribute specified when the EC2 instance is launched. The only other option is dedicated, which ensures that EC2 instances launched in this VPC are run on dedicated tenancy instances regardless of the tenancy attribute specified at launch. This has a dedicated per region fee of $2 per hour, plus an hourly per instance usage fee."
//  type = string
//}
//
//variable "vpc_name" {
//  description = "Name assigned to the VPC"
//  type = string
//}

variable "public_subnets" {
  description = "Each list of objects contains the configuration for a subnet. subnet_cidr_block: The IPv4 CIDR block for the subnet. availability_zone: The AZ of the subnet. map_public_ip_on_launch: Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  type = list(object({
    name = string
    cidr_block = string
    availability_zone = string
    map_public_ip_on_launch = bool
  }))
}

variable "private_subnets" {
  description = "Each list of objects contains the configuration for a subnet. subnet_cidr_block: The IPv4 CIDR block for the subnet. availability_zone: The AZ of the subnet. map_public_ip_on_launch: Specify true to indicate that instances launched into the subnet should be assigned a public IP address."
  type = list(object({
    name = string
    cidr_block = string
    availability_zone = string
    map_public_ip_on_launch = bool
  }))
}

//variable "subnet_cidr_block" {
//  description = "The IPv4 CIDR block for the subnet." 
//  type = string
//}
//
//variable "availability_zone" {
//  description = "AZ of the subnet."
//  type = string
//}
//
//variable "map_public_ip_on_launch" {
//  description = "Specify true to indicate that instances launched into the subnet should be assigned a public IP address. Default is false"
//  type = bool
//  default = false
//}
//
//variable "subnet_name" {
//  description = "Name assigned to the subnet"
//  type = string
//}

variable "public_route_table_name" {
  description = "Name assigned to the route table"
  type = string
}

variable "private_route_table_name" {
  description = "Name assigned to the route table"
  type = string
}

variable "nat_gateway_id" {
  description = "NAT gateway id assigned to private route table"
  type = string
}

variable "igw_id" {
  description = "Internet Gateway ID for public route table"
  type = string
}

variable "vpc_id" {
  description = "VPC ID assigned to subnets"
  type = string
}
