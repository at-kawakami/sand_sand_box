resource "aws_lb_target_group" "hello_func" {
  connection_termination             = false
  deregistration_delay               = 300
  ip_address_type                    = "ipv4"
  lambda_multi_value_headers_enabled = false
  name                               = "helloFunc"
  preserve_client_ip                 = null
  tags                               = {}
  tags_all                           = {}
  target_type                        = "lambda"
  vpc_id                             = null
  health_check {
    enabled             = false
    healthy_threshold   = 2
    interval            = 35
    matcher             = jsonencode(200)
    path                = "/"
    port                = null
    protocol            = null
    timeout             = 30
    unhealthy_threshold = 2
  }
}
