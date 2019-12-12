output "sn_id" {
  value = aws_subnet.public.*.id
}

