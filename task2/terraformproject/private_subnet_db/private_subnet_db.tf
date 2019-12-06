resource "aws_subnet" "sn-private-db" {

  cidr_block              = "10.11.20.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  availability_zone       = "us-east-1a"

  vpc_id = var.vpc_id

  tags = {
    Name = "tera-abotyan-training-sn-private-db-a"
  }
}
