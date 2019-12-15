resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    "Name"        = "dev-abotyan-sn-public-${element(var.availability_zones, count.index)}"
    "description" = "better-tera-abotyan. Public subnet - ${element(var.availability_zones, count.index)}"
  }
}
