resource "aws_route_table" "private-rt" {
  vpc_id = var.vpc_id
  count  = length(var.availability_zones)

  route {
    cidr_block  = "0.0.0.0/0"
    instance_id = element(var.igw_id, count.index)
  }

  tags = {
    "Name"        = "abotyan-rt-private${count.index}"
    "owner"       = "abotyan"
    "description" = "better-terra-abotyan-rt-nat. For private subnets in ${element(var.availability_zones, count.index)} to outside route to NAT${count.index}"
  }
}
