output "sn_id" {
    value = aws_subnet.database.*.id
}
