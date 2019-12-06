resource "aws_subnet" "sn-private-backend" {

  cidr_block              = "10.11.10.0/24"
  map_public_ip_on_launch = "false" //it makes this a public subnet
  #  availability_zone       = "us-east-1a"

  availability_zone = var.az
  vpc_id            = var.vpc_id

  tags = {
    Name = "tera-abotyan-sn-private-be-a"
  }
}
