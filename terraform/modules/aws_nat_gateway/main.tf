resource "aws_nat_gateway" "main" {
    
  allocation_id     = "${var.eip_allocate_id}"
  connectivity_type = "public"
  subnet_id         = "${var.public_subnet1}"
  tags = {
    Name = "${var.name}-nat-public1-ap-northeast-1a"
  }
  tags_all = {
    Name = "${var.name}-nat-public1-ap-northeast-1a"
  }
}