// Create Public Subnets
resource "aws_subnet" "public" {
  for_each = { for obj in var.public_subnets : obj.name => obj }
  vpc_id     = var.vpc_id 
  cidr_block = each.value.cidr_block 
  availability_zone = each.value.availability_zone 
  map_public_ip_on_launch = each.value.map_public_ip_on_launch 

  tags = {
    Name = each.value.name 
  }
}

// Create a route table for our public subnet(s)
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id 

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id 
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
  vpc_id     = var.vpc_id 
  cidr_block = each.value.cidr_block 
  availability_zone = each.value.availability_zone 
  map_public_ip_on_launch = each.value.map_public_ip_on_launch 

  tags = {
    Name = each.value.name 
  }
}

// Create a route table for our private subnet(s)
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id 

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = var.nat_gateway_id 
  }

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
