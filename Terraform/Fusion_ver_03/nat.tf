################### nat.tf
### NAT 게이트웨이(01, 02), NAT eip(01, 02)

################### NAT 게이트웨이 & EIP on pub_A_10
resource "aws_nat_gateway" "nat-01" {
  allocation_id = aws_eip.nat-eip-01.id
  subnet_id     = aws_subnet.pub_A_10.id

  tags = {
    Name = "MIR-nat-01"
  }

  # 버전 갱신시 인스턴스 롤링 업데이트.
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_eip" "nat-eip-01" {
  domain = "vpc"

  tags = {
    Name = "MIR-nat-eip-01"
  }
}

################### NAT 게이트웨이 & EIP on pub_C_20
resource "aws_nat_gateway" "nat-02" {
  allocation_id = aws_eip.nat-eip-02.id
  subnet_id     = aws_subnet.pub_C_10.id

  tags = {
    Name = "MIR-nat-02"
  }

  # 버전 갱신시 인스턴스 롤링 업데이트.
  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.igw]
}
resource "aws_eip" "nat-eip-02" {
  domain = "vpc"

  tags = {
    Name = "MIR-nat-eip-02"
  }
}