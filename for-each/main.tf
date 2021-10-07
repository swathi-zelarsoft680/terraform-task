provider "aws" {
  region = "us-east-1"
}
variable "vpcs" {
  type = map(object({
    cidr = string
    tags = map(string)
    tenancy =string
  }))
 default = {
   "one" = {
     cidr = "10.0.0.0.16"
     tags = {
       "Name" = "vpc-one"  
     } 
     tenancy = "default"
   } 
   "two" = {
     cidr = "10.20.0.0.16"
     tags = {
       "Name" = "vpc-two"  
     } 
     tenancy = "default"
   }  
 }
}

resource "aws_vpc" "main" {
  for_each = var.vpcs
  cidr_block = each.value["cidr"]
  instance_tenency = each.value["tenancy"]
  tags = each.value["tags"]
}