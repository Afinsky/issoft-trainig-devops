output "sn_id" {
  value = aws_subnet.frontend.*.id
}
