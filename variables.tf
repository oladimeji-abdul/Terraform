variable "aws_access_key" {
    type = string
    description = "holds the AWS access key"
    sensitive = true
  
}

variable "aws_secret_key" {
    type = string
    description = "holds the AWS secret key"
    sensitive = true
  
}

variable "aws_instance_sizes" {
    type = map(string)
    description = "this maps instance sizes to a variable"
    default = {
      small     = "t2.micro"
      medium    = "t2.small"
      large     = "t2.large"
    }
  
}

variable "instance_type" {
  type        = string
  description = "Type for EC2 Instance"
  default     = "t2.micro"
}


variable "aws_regions" {
    type = list(string)
    description = "this is a list of aws regions that can be referenced"
    default = [ "us-east-1", "us-east-2", "us-west-1" ]
  
}

variable "aws_vpc_cidr" {
type = string
description = "cidr for the vpc"
default = "10.0.0.0/16"

}

#variable "project_tags" {
##    description = "tag values"
 #   default = {
 #     project_name = "aws_project_new"
 #     company_name = "kabu"
 #   }
  
#}

variable "company" {
    type = string
    description = "company name"
  
}

variable "project" {
    type = string
    description = "project name"
  
}

variable "aws_subnet_cidr" {
type = list(string)
description = "cidr for the vpc"
default = ["10.0.10.0/24", "10.0.1.0/24"]

}

variable "availability_zone" {
type = string
description = "availability zone"
default = "us-east-1a"

}