resource "aws_internet_gateway" "igw" {

  vpc_id = var.vpc_id

  tags = {
    Name = "dev-abotyan-igw"
    description = "better-tera-abotyan-igw"
  }
}
