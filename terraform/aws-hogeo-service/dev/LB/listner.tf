resource "aws_lb_listener" "hello_func" {
  alpn_policy       = null
  certificate_arn   = aws_acm_certificate.cert.id
  load_balancer_arn = aws_lb.hogeo.id
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-2021-06"
  tags              = {}
  tags_all          = {}
  default_action {
    order            = 1
    target_group_arn = aws_lb_target_group.hello_func.id
    type             = "forward"
  }
}

# __generated__ by Terraform
resource "aws_lb_listener_rule" "hello_func" {
  listener_arn = aws_lb_listener.hello_func.id
  priority     = 1
  tags         = {
    "Name" = "helloFunc"
  }
  tags_all     = {
    "Name" = "helloFunc"
  }
  condition {}
  action {
    order            = 1
    target_group_arn = aws_lb_target_group.hello_func.id
    type             = "forward"
  }
}
