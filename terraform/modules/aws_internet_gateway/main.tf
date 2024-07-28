resource "aws_internet_gateway" "main" {
  tags = {
    Name = "${var.name}-igw"
  }
  tags_all = {
    Name = "${var.name}-igw"
  }
  vpc_id = "${var.vpc_id}"
}
