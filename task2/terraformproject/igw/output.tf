output "igw_id" {
  #Name of output value
  #resource.module_name.output_value_name

  value = aws_internet_gateway.igw.id

}
