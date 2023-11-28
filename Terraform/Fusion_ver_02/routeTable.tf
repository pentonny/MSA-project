################### routeTable.tf
### Pub&Pri 라우팅 테이블&연결(A, C)

################### PUB 라우팅 테이블 (A, C)
### 테이블 pub 공용
resource "aws_route_table" "pub_rtb" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "MIR-PUB_AC-RTB"
  }
}

### 연결 pub A, C
resource "aws_route_table_association" "pub-sub-rtb" {
  count          = length(var.AZz)
  subnet_id      = aws_subnet.pub[count.index].id
  route_table_id = aws_route_table.pub_rtb.id
}

################### PRI 라우팅 테이블 A (used nat-01)
### 테이블&연결 PRI-서브넷 A(11, 12, 13)
resource "aws_route_table" "pri_rtb-a" {
  vpc_id = aws_vpc.main.id
  count  = length(var.Pri_net_A)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
  }
  tags = { Name = "pri-rtb-a-${var.Pri_net_A[count.index]}" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-a" {
  count          = length(var.Pri_net_A)
  subnet_id      = aws_subnet.pri_A[count.index].id
  route_table_id = aws_route_table.pri_rtb-a[count.index].id
}

################### PRI 라우팅 테이블 C (used nat-02)
### 테이블&연결 PRI-서브넷 C(21, 22, 23)
resource "aws_route_table" "pri_rtb-c" {
  vpc_id = aws_vpc.main.id
  count  = length(var.Pri_net_C)
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[1].id
  }
  tags = { Name = "pri-rtb-c-${var.Pri_net_C[count.index]}" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-c" {
  count          = length(var.Pri_net_C)
  subnet_id      = aws_subnet.pri_C[count.index].id
  route_table_id = aws_route_table.pri_rtb-c[count.index].id
}