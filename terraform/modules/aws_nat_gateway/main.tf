resource "aws_nat_gateway" "main" {
    
  allocation_id     = "eipalloc-0aa39755adcf90941"
  connectivity_type = "public"
  subnet_id         = "${var.public_subnet1}"
  tags = {
    Name = "${var.name}-nat-public1-ap-northeast-1a"
  }
  tags_all = {
    Name = "${var.name}-nat-public1-ap-northeast-1a"
  }
}