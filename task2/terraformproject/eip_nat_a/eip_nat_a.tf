resource "aws_eip" "nat-a" {
  instance = var.instance_id
  vpc      = true

  tags = {
    Name = "tera-abotyan-eip-nat-a"
  }
}
