resource "aws_route_table_association" "db-association" {
  count     = length(var.availability_zones)
  subnet_id = element(var.sn_id, count.index)

  route_table_id = element(var.rt_id, count.index)
}
