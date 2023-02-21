variable "aws_regions" {
    type = list(string)
    description = "this is a list of aws regions that can be referenced"
    default = [ "us-east-1", "us-east-2", "us-west-1" ]
  
}

#to reference this, use the format below

#var.aws_regions[0]

variable "aws_instance_sizes" {
    type = map(string)
    description = "this maps instance sizes to a variable"
    default = {
      small     = "t2.micro"
      medium    = "t2.small"
      large     = "t2.large"
    }
  
}

#to refernce this, use the format below

#var.aws_instance_sizes.small or var.aws_instance_sizes["medium"]

#local variables are defined inside the configuration file