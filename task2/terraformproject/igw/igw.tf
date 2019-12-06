resource "aws_internet_gateway" "tera-abotyan-training-igw" {

  vpc_id = module.vpc.vpc_id

  tags = {
    Name = "tera-abotyan-training-igw"
  }
}
