resource "aws_instance" "lb" {
  ami           = var.aws_ami
  instance_type = var.proxy_instance_type

  count = length(var.availability_zones)
  subnet_id = element(var.sn_id, count.index)

  key_name        = var.key_id
  security_groups = [var.sg_id]

  associate_public_ip_address = true

  tags = {
    Name = "dev-abotyan-lb-${element(var.availability_zones, count.index)}"
    description = "better-tera-abotyan-lb. Public subnet - ${element(var.availability_zones, count.index)}"
  }
}
