resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_block
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name        = "abotyan-vpc"
    owner       = "abotyan"
    description = "better-tera-abotyan-vpc"
  }
}
