resource "aws_eip" "main" {
  network_border_group      = "ap-northeast-1"
  network_interface         = "${var.aws_network_interface_id}"
  public_ipv4_pool          = "amazon"
  tags = {
    Name = "${var.name}-eip-ap-northeast-1a"
  }
  tags_all = {
    Name = "${var.name}-eip-ap-northeast-1a"
  }
  vpc = true
}