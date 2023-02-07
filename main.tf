provider "aws" {
  region = "us-east-1"
  access_key = ""
  secret_key = ""
}
resource "aws_vpc" "dev-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Dev"
    }
  
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dev-subnet-1"
  }
}

data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.default_vpc.id
  cidr_block = "172.31.16.0/20"
  availability_zone = "us-east-1a"
   tags = {
    Name = "dev-subnet-2"
  }
}