resource "aws_subnet" "database" {
  count                   = length(var.availability_zones)
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + 20)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    "Name"        = "abotyan-db-sn"
    "owner"       = "abotyan"
    "region"      = "${element(var.availability_zones, count.index)}"
    "description" = "better-terra-abotyan. Database subnet - ${element(var.availability_zones, count.index)}"
  }
}
