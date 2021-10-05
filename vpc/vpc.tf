provider "aws" {
  region     = "us-east-1"
}

 /*create vpc*/
resource "aws_vpc" "vpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "demo-vpc"
  }
}

 /*creating  pub subnets*/
resource "aws_subnet" "pub" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "public"
  }
}

/*creating private subnet*/
resource "aws_subnet" "pri" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "192.168.3.0/24"

  tags = {
    Name = "private"
  }
}

 /*creating internet_gateway*/
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW"
  }
}

 /*create elasticIP*/
resource "aws_eip" "ip" {
  vpc      = true
}

 /*create natgateway*/
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.pri.id

  tags = {
    Name = "NGW"
  }
}
 /*create public routetable*/
resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    }
 tags = {
    Name = "custom"
  }
}

 /*create private route table*/
resource "aws_route_table" "rt2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
    }
 tags = {
    Name = "main"
  }
}

 /*Associate public subnets to routetable*/
resource "aws_route_table_association" "as_1" {
  subnet_id      = aws_subnet.pub.id
  route_table_id = aws_route_table.rt1.id
}

/*Associate private subnet to route table*/
resource "aws_route_table_association" "as_2" {
  subnet_id      = aws_subnet.pri.id
  route_table_id = aws_route_table.rt2.id
}

/*create security groups*/
resource "aws_security_group" "sg" {
  name        = "first-SG"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
 }


  tags = {
    Name = "first-SG"
  }
}
