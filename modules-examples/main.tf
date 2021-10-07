provider "aws" {
  region     = "us-east-1"
  shared_credentials_file = "D:/.aws/credentials"
}



resource "aws_vpc" "main" {
	cidr_block = "10.0.0.0/16"
}


data "aws_vpc" "foo" {
	provider = "aws"
	default  = true
}




module "webserver" {
	source        = "./modules"
	name          = "tuts-webserver"
	vpc_id        = aws_vpc.main.id
	cidr_block    = cidrsubnet(aws_vpc.main.cidr_block, 4, 1)
	ami           = "ami-0eb5f3f64b10d3e0e"
	instance_type = "t2.micro"
}

output "webserver" {
	value = module.webserver.instance.public_ip
}

output "foo" {
	value = data.aws_vpc.foo
}

