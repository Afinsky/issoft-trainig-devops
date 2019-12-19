resource "aws_alb" "public_alb_instance" {
  name            = "abotyan-public-alb"
  subnets         = var.sn_id
  security_groups = [var.sg_id]

  internal = false
  

  tags = {
    Name        = "abotyan-public-alb"
    owner       = "abotyan"
    description = "better-terra-abotyan-public-alb. Public ALB"
  }
}
