###############################################
#Providers
###############################################

provider "aws" {
  region = var.aws_regions[0]
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

###############################################
#Data
###############################################

data "aws_vpc" "default_vpc" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

###############################################
#Resources
###############################################

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.aws_vpc_cidr
    tags = local.common_tags
  
}

###############################################
#Resources.SUBNETS
###############################################


resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.aws_subnet_cidr[0]
  availability_zone = data.aws_availability_zones.available.names[1]
  tags = local.common_tags
}


resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.default_vpc.id
  cidr_block = var.aws_subnet_cidr[1]
  availability_zone = data.aws_availability_zones.available.names[0]
   tags = {
    Name = "dev-subnet-2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.dev-vpc.id

  tags = local.common_tags
  
}

#ROUTING

resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.dev-vpc.id
  route {
    cidr_block = "0.0.0.0/10"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.dev-subnet-1.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_route_table_association" "rtb2" {
  subnet_id = aws_subnet.dev-subnet-2.id
  route_table_id = aws_route_table.rtb.id
}

resource "aws_security_group" "sg1" {
  name = "rsg1"

  #enable HTTP access from anywhere
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

#outbound rule definition
  egress {

    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "tcp"
    to_port = 0
  } 

}

resource "aws_security_group" "sg2" {
  name = "rsg2"

  #enable HTTP access from anywhere
  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [ var.aws_vpc_cidr ]
  }

#outbound rule definition
  egress {

    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "tcp"
    to_port = 0
  } 

}
