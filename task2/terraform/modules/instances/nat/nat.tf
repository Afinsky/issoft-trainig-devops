resource "aws_instance" "nat" {
  ami           = var.aws_ami
  instance_type = var.nat_instance_type

  count     = length(var.availability_zones)
  subnet_id = element(var.sn_id, count.index)

  key_name        = var.key_id
  security_groups = [var.sg_id]

  associate_public_ip_address = true
  source_dest_check           = false

  user_data = <<EOF
#!/bin/bash


sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -A POSTROUTING -o `netstat -i | awk '{print $1}' | grep -vE '(Kernel|Iface)' | grep -v lo` -s ${var.cidr_block} -j MASQUERADE
EOF


  tags = {
    Name        = "abotyan-nat"
    owner       = "abotyan"
    region      = "${element(var.availability_zones, count.index)}"
    description = "better-terra-abotyan-nat. Public subnet - ${element(var.availability_zones, count.index)}"
  }
}
