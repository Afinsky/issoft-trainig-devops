resource "aws_instance" "nexus" {
  ami           = var.aws_ami
  instance_type = var.nexus_instance_type

  #count = length(var.availability_zones)
  #subnet_id = element(var.sn_id, count.index)

  #Because need only one instance: us-east-1a
  subnet_id = element(var.sn_id, 0)


  key_name        = var.key_id
  security_groups = [var.sg_id]

  #associate_public_ip_address = true
  #count.index ->0
  tags = {
    Name        = "abotyan-nexus"
    owner       = "abotyan"
    region      = "${element(var.availability_zones, 0)}"
    description = "better-terra-abotyan-nexus. Infrastructure subnet - ${element(var.availability_zones, 0)}"
  }
}
