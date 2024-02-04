// Create a VPC
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block 
  instance_tenancy = var.vpc_instance_tenancy 

  tags = {
    Name = var.vpc_name 
  }
}

// Create an Internet Gateway and attach to VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw_name 
  }
}

// Create Subnet
resource "aws_subnet" "main" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.subnet_cidr_block 
  availability_zone = var.availability_zone
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = var.subnet_name 
  }
}

// Create a route table four our public subnet(s)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.route_table_name 
  }
}

// Associate above route table with a subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.public.id
}
