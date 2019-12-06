resource "aws_vpc" "tera-abotyan-training-vpc" {
  cidr_block           = "10.11.0.0/16"
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "tera-abotyan-vpc-training"
  }
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.tera-abotyan-training-vpc.id
}
