resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    #    instance_id = aws_instance.nat-a.id
  }

  tags = {
    "Name" = "tera-abotyan-training-rt-nat-a"
  }
}
