resource "aws_route_table" "public-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    "Name" = "dev-abotyan-rt"
    "description" = "better-tera-abotyan-rt-igw"
  }
}
