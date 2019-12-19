resource "aws_subnet" "infra" {
  count                   = length(var.availability_zones)
  vpc_id                  = var.vpc_id
  cidr_block              = cidrsubnet(var.cidr_block, 8, count.index + 40)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = false

  tags = {
    "Name"        = "abotyan-infra-sn"
    "owner"       = "abotyan"
    "region"      = "${element(var.availability_zones, count.index)}"
    "description" = "better-terra-abotyan. Insrastructure subnet - ${element(var.availability_zones, count.index)}"
  }
}
