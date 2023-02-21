output "aws_vpc_sec_grp" {
    value = aws_vpc.dev-vpc.default_security_group_id

}