provider "aws" {
  region = var.aws_regions[0]
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.aws_vpc_cidr
    tags = local.common_tags
  
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = var.aws_subnet_cidr[0]
  availability_zone = var.availability_zone
  tags = local.common_tags
}

data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2" {
  vpc_id = data.aws_vpc.default_vpc.id
  cidr_block = var.aws_subnet_cidr[1]
  availability_zone =var.availability_zone
   tags = {
    Name = "dev-subnet-2"
  }
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

resource "aws_instance" "web-server1" {
  ami = nonsensitive(data.aws_ssm.parameter.ami.value)
  instance_type = var.aws_instance_sizes.small
  subnet_id = aws_subnet.dev-subnet-1
  vpc_security_group_ids = [aws_security_group.sg1.id]

  user_data = <<EOF
#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
sudo rm /usr/share/nginx/html/index.html
echo '<html><head><title>Taco Team Server</title></head><body style=\"background-color:#1F778D\"><p style=\"text-align: center;\"><span style=\"color:#FFFFFF;\"><span style=\"font-size:28px;\">You did it! Have a &#127790;</span></span></p></body></html>' | sudo tee /usr/share/nginx/html/index.html
EOF

}
