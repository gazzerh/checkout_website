
# define application load-balancer
resource "aws_alb" "load_balancer" {
  load_balancer_type = "application"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.app_lb.id]
}

resource "aws_alb_target_group" "target_group" {
  vpc_id      = var.vpc_id
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = aws_alb.load_balancer.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.acm_cert.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
}
