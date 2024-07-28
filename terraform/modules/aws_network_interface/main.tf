resource "aws_network_interface" "main" {
  description    = "Interface for NAT Gateway ${var.nat_id}"
  private_ip_list_enabled = true
  source_dest_check = false
  subnet_id         = var.public_subnet1
  tags              = {}
  tags_all          = {}
}