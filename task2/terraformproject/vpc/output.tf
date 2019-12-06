output "vpc_id" {
  #Name of output value
  #resource.module_name.output_value_name

  value = aws_vpc.vpc.id

}
