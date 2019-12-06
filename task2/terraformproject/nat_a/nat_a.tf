resource "aws_instance" "nat-a" {
  ami           = var.AWS_NAT_AMI
  instance_type = var.instance_type

  subnet_id       = var.sn_id
  key_name        = var.key_id
  security_groups = [var.sg_id]

  associate_public_ip_address = true
  source_dest_check           = false

  user_data = <<EOF
#!/bin/bash

sudo echo 1 > /proc/sys/net/ipv4/ip_forward
sudo iptables -t nat -A POSTROUTING -o `netstat -i | awk '{print $1}' | grep -vE '(Kernel|Iface)' | grep -v lo` -s 10.11.0.0/16 -j MASQUERADE

EOF

  tags = {
    Name = "tera-abotyan-nat-a"
  }
}
