# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "eipalloc-0aa39755adcf90941"
resource "aws_eip" "main" {
  address                   = null
  associate_with_private_ip = null
  customer_owned_ipv4_pool  = null
  instance                  = null
  network_border_group      = "ap-northeast-1"
  network_interface         = "eni-0bff71e368ae53864"
  public_ipv4_pool          = "amazon"
  tags = {
    Name = "hogeo-eip-ap-northeast-1a"
  }
  tags_all = {
    Name = "hogeo-eip-ap-northeast-1a"
  }
  vpc = true
}
