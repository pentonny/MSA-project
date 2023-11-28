################### nat.tf
### NAT 게이트웨이(01, 02), NAT eip(01, 02)

################### NAT 게이트웨이 & EIP on pub
resource "aws_nat_gateway" "nat" {
  count         = length(var.AZz)
  allocation_id = aws_eip.nat-eip[count.index].id
  subnet_id     = aws_subnet.pub[count.index].id

  tags = {
    Name = "MIR-nat-${var.AZz[count.index]}"
  }

  # 버전 갱신시 인스턴스 롤링 업데이트.
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_eip" "nat-eip" {
  count  = length(var.AZz)
  domain = "vpc"

  tags = {
    Name = "MIR-nat-eip-${var.AZz[count.index]}"
  }
}