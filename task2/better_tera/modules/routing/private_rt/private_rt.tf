resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id
  count  = length(var.availability_zones)

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = element(var.igw_id, count.index)
  }

  tags = {
    "Name"        = "dev-abotyan-rt-nat-${element(var.availability_zones, count.index)}"
    "description" = "better-tera-abotyan-rt-nat. Route table to NAT in ${element(var.availability_zones, count.index)}"
  }
}
