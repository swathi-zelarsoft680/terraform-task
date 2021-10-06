 terraform {
   backend "remote" {
     organization = "swathizs"

     workspaces {
       name = "swathi"
     }
   }
   required_providers {
     aws = {
       source  = "hashicorp/aws"
      version = "~> 3.27"
    }
   }

   required_version = ">= 1.0.6"
 }
provider "aws" {
  profile = "default"
  region  = var.region
}

/*create vpc*/
resource "aws_vpc" "vpc" {
  cidr_block              = var.vpc-cidr
  instance_tenancy        = "default"
  enable_dns_hostnames    = true

  tags      = {
    Name    = "vpc1"
  }
}

/*creating internet_gateway*/
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW"
  }
}

/*creating public subnets*/
resource "aws_subnet" "pub-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub-subnet-1-cidr
  availability_zone       = "us-east-1a"
  
  tags      = {
    Name    = "Pub Subnet 1"
  }
}

resource "aws_subnet" "pub-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub-subnet-2-cidr
  availability_zone       = "us-east-1b"
  
  tags      = {
    Name    = "Pub Subnet 2"
  }
}

resource "aws_subnet" "pub-subnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pub-subnet-3-cidr
  availability_zone       = "us-east-1c"

  tags      = {
    Name    = "Pub Subnet 3"
  }
}

/*creating public routetable*/
resource "aws_route_table" "pub-route-table" {
  vpc_id       = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags       = {
    Name     = "Pub Route Table"
  }
}

/*Associate Public Subnets to routetables*/
resource "aws_route_table_association" "pub-subnet-1-route-table-association" {
  subnet_id           = aws_subnet.pub-subnet-1.id
  route_table_id      = aws_route_table.pub-route-table.id
}
resource "aws_route_table_association" "pub-subnet-3-route-table-association" {
  subnet_id           = aws_subnet.pub-subnet-2.id
  route_table_id      = aws_route_table.pub-route-table.id
}
resource "aws_route_table_association" "pub-subnet-2-route-table-association" {
  subnet_id           = aws_subnet.pub-subnet-3.id
  route_table_id      = aws_route_table.pub-route-table.id
}

/*creating private subnets*/
resource "aws_subnet" "pri-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri-subnet-1-cidr
  availability_zone       = "us-east-1a"
 
  tags      = {
    Name    = "pri Subnet 1"
  }
}

resource "aws_subnet" "pri-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri-subnet-2-cidr
  availability_zone       = "us-east-1b"
  
  tags      = {
    Name    = "pri Subnet 2"
  }
}

resource "aws_subnet" "pri-subnet-3" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.pri-subnet-3-cidr
  availability_zone       = "us-east-1c"
 
  tags      = {
    Name    = "pri Subnet 3"
  }
}