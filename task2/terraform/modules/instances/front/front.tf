resource "aws_instance" "front" {
  ami           = var.aws_ami
  instance_type = var.front_instance_type

  count     = length(var.availability_zones)
  subnet_id = element(var.sn_id, count.index)

  key_name        = var.key_id
  security_groups = [var.sg_id]

  associate_public_ip_address = false

  tags = {
    Name        = "abotyan-front"
    owner       = "abotyan"
    region      = "${element(var.availability_zones, count.index)}"
    description = "better-terra-abotyan-front. Frontend subnet - ${element(var.availability_zones, count.index)}"
  }
}