# Creating a VPC with minimal settings

provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "deham14" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "WebServerVPC"
  }
}


# Create Public Subnet 1 in the VPC
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.deham14.id
  cidr_block              = "10.0.1.0/24" 
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet1"
  }
}

# Create Public Subnet 2 in the VPC
resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.deham14.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "PublicSubnet2"
  }
}

# Create Private Subnet 1 in the VPC
resource "aws_subnet" "private_subnet_1" {
  vpc_id                  = aws_vpc.deham14.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "eu-north-1a"
  map_public_ip_on_launch = false
  tags = {
    Name = "PrivateSubnet1"
  }
}

# Create Private Subnet 2 in the VPC
resource "aws_subnet" "private_subnet_2" {
  vpc_id                  = aws_vpc.deham14.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "eu-north-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "PrivateSubnet2"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "deham14-igw" {
  vpc_id = aws_vpc.deham14.id

  tags = {
    Name = "WebServerIG"
  }
}

# Output
output "vpc_id" {
  value = aws_vpc.deham14.id
}

output "public_subnet_1_id" {
  value = aws_subnet.public_subnet_1.id
}

output "private_subnet_1_id" {
  value = aws_subnet.private_subnet_1.id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.deham14-igw.id
}


