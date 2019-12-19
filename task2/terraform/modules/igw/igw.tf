resource "aws_internet_gateway" "igw" {

  vpc_id = var.vpc_id

  tags = {
    Name        = "abotyan-igw"
    owner       = "abotyan"
    description = "better-terra-abotyan-igw"
  }
}
