resource "aws_alb_listener" "public_alb_listener" {
  load_balancer_arn = var.load_balancer_arn
  
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
        host        = "#{host}"
        path        = "/#{path}"
        port        = "443"
        protocol    = "HTTPS"
        query       = "#{query}"
        status_code = "HTTP_301"
    }
  }
}
