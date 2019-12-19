resource "aws_key_pair" "key" {
  key_name   = var.key_name
  public_key = file(var.pub_key_path)
}