# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "arn:aws:elasticloadbalancing:ap-northeast-1:571429965935:loadbalancer/app/hoge-stephen-hogeo-net/4e4209b74ba7c1b0"
resource "aws_lb" "hoge_stephen_hogeo_net" {
  customer_owned_ipv4_pool                    = null
  desync_mitigation_mode                      = "defensive"
  drop_invalid_header_fields                  = false
  enable_cross_zone_load_balancing            = true
  enable_deletion_protection                  = false
  enable_http2                                = true
  enable_tls_version_and_cipher_suite_headers = false
  enable_waf_fail_open                        = false
  enable_xff_client_port                      = false
  idle_timeout                                = 60
  internal                                    = false
  ip_address_type                             = "ipv4"
  load_balancer_type                          = "application"
  name                                        = "hoge-stephen-hogeo-net"
  name_prefix                                 = null
  preserve_host_header                        = false
  security_groups                             = ["sg-0fe30e327629f6072"]
  subnets                                     = ["subnet-0dcc5856", "subnet-fcfaa2b5"]
  tags                                        = {}
  tags_all                                    = {}
  xff_header_processing_mode                  = "append"
  access_logs {
    bucket  = ""
    enabled = false
    prefix  = null
  }
  subnet_mapping {
    allocation_id        = null
    ipv6_address         = null
    private_ipv4_address = null
    subnet_id            = "subnet-0dcc5856"
  }
  subnet_mapping {
    allocation_id        = null
    ipv6_address         = null
    private_ipv4_address = null
    subnet_id            = "subnet-fcfaa2b5"
  }
}
