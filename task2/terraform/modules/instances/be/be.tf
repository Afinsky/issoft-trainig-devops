resource "aws_instance" "be" {
  ami           = var.aws_ami
  instance_type = var.app_instance_type

  count     = length(var.availability_zones)
  subnet_id = element(var.sn_id, count.index)

  key_name        = var.key_id
  security_groups = [var.sg_id]

  associate_public_ip_address = false

  tags = {
    Name        = "dev-abotyan-app-${element(var.availability_zones, count.index)}"
    description = "better-tera-abotyan-be. Application subnet - ${element(var.availability_zones, count.index)}"
  }
}
