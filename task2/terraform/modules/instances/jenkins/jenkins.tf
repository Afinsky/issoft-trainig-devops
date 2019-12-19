resource "aws_instance" "jenkins" {
  ami           = var.aws_ami
  instance_type = var.jenkins_instance_type

  #count = length(var.availability_zones)
  #subnet_id = element(var.sn_id, count.index)

  #Because need only one instance: us-east-1a
  subnet_id = element(var.sn_id, 0)


  key_name        = var.key_id
  security_groups = [var.sg_id]

  #associate_public_ip_address = true
  #count.index ->0
  

  tags = {
    Name        = "abotyan-jenkins"
    owner       = "abotyan"
    region      = "${element(var.availability_zones, 0)}"
    description = "better-terra-abotyan-jenkins. Infrastructure subnet - ${element(var.availability_zones, 0)}"
  }


#provisioner "local-exec" {
#    command = <<EOT
#>../ansible/jenkins.ini;
#echo "[jenkins]" | tee -a ../ansible/jenkins.ini;
#echo "${aws_instance.jenkins.private_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=../terraform/abotyan-tera-key" | tee -a ../ansible/jenkins.ini;
#ansible-playbook -i ../ansible/jenkins.ini ../ansible/jenkins.yaml
#EOT
#}
}
