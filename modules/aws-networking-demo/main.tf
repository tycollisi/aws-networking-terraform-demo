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

// Create Public Subnets
resource "aws_subnet" "public" {
  for_each = { for obj in var.public_subnets : obj.name => obj }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block 
  availability_zone = each.value.availability_zone 
  map_public_ip_on_launch = each.value.map_public_ip_on_launch 

  tags = {
    Name = each.value.name 
  }
}

// Create a route table for our public subnet(s)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.public_route_table_name 
  }
}

// Associate above route table with a subnet
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public
  subnet_id      = each.value.id 
  route_table_id = aws_route_table.public.id
}

// Create Private Subnets
resource "aws_subnet" "private" {
  for_each = { for obj in var.private_subnets : obj.name => obj }
  vpc_id     = aws_vpc.main.id
  cidr_block = each.value.cidr_block 
  availability_zone = each.value.availability_zone 
  map_public_ip_on_launch = each.value.map_public_ip_on_launch 

  tags = {
    Name = each.value.name 
  }
}

// Create a route table for our private subnet(s)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  //route {
  //  cidr_block = "0.0.0.0/0"
  //  gateway_id = aws_internet_gateway.gw.id
  //}

  tags = {
    Name = var.private_route_table_name 
  }
}

// Associate above route table with a subnet
resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id 
  route_table_id = aws_route_table.private.id
}
