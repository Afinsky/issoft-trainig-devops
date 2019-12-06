resource "aws_vpc" "vpc" {
  cidr_block           = "10.11.0.0/16"
  enable_dns_support   = "true" #gives you an internal domain name
  enable_dns_hostnames = "true" #gives you an internal host name
  enable_classiclink   = "false"
  instance_tenancy     = "default"

  tags = {
    Name = "tera-abotyan-vpc-training"
  }
}

##############SUBNETS###########################################

resource "aws_subnet" "sn-public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.11.0.0/24"
  map_public_ip_on_launch = "true" //it makes this a public subnet
  availability_zone       = "us-east-1a"

  tags = {
    Name = "tera-abotyan-training-sn-public-a"
  }
}

resource "aws_subnet" "sn-private-be-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.11.10.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "us-east-1a"

  tags = {
    Name = "tera-abotyan-training-sn-private-backend-a"
  }
}

resource "aws_subnet" "sn-private-db-a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.11.20.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "us-east-1a"

  tags = {
    Name = "tera-abotyan-training-sn-private-db-a"
  }
}
