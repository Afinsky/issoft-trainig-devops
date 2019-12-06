resource "aws_subnet" "tera-abotyan-training-sn-private-db-a" {
  vpc_id                  = aws_vpc.tera-abotyan-training-vpc.id
  cidr_block              = "10.11.20.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "us-east-1a"

  tags = {
    Name = "tera-abotyan-training-sn-private-db-a"
  }
}
