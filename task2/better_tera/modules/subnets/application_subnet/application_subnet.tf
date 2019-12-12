resource "aws_subnet" "application" {
  count                   = length(var.availability_zones)
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + 10)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    "Name"        = "dev-abotyan-sn-private-app-${element(var.availability_zones, count.index)}"
    "description" = "better-tera-abotyan. Application subnet - ${element(var.availability_zones, count.index)}"
  }
}
