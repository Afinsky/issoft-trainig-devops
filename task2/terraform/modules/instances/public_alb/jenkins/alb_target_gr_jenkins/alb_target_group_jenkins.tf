resource "aws_alb_target_group" "alb_jenkins_gr" {
  name = "abotyan-jenkins-tg"
  port = "8080"
  protocol = "HTTP"
  vpc_id = var.vpc_id

  tags = {
    Name  = "abotyan-jenkins-tg"
    owner = "abotyan"
  }

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 30
    interval            = 5
    matcher             = "200-499"
    path                = "/"
    port                = "8080"
    protocol            = "HTTP"
  }
}
