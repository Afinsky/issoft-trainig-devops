output "sn_id" {
    value = aws_subnet.application.*.id
}
