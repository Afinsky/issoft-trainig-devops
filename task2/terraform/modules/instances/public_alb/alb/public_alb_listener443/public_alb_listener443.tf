resource "aws_alb_listener" "public_alb_listener443" {
  load_balancer_arn = var.load_balancer_arn
  
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:acm:us-east-1:242906888793:certificate/f2e8b0e6-aa7a-48be-bedb-945df54a55f2"

  default_action {
    type = "forward"
    target_group_arn = var.target_gr_arn    
  }
}
