resource "aws_network_interface" "main" {
  description               = "Interface for NAT Gateway ${var.nat_id}"
  #todo
  private_ip                = "10.0.11.17"
  source_dest_check         = false
  subnet_id                 = "${var.public_subnet1}"
  tags                      = {}
  tags_all                  = {}
  attachment {
    device_index = 1
    instance     = ""
  }
}