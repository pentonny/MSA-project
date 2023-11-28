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

### 연결 pub A_10
resource "aws_route_table_association" "pub-sub-rtb-a" {
  subnet_id      = aws_subnet.pub_A_10.id
  route_table_id = aws_route_table.pub_rtb.id
}
### 연결 pub C_20
resource "aws_route_table_association" "pub-sub-rtb-c" {
  subnet_id      = aws_subnet.pub_C_10.id
  route_table_id = aws_route_table.pub_rtb.id
}

################### PRI 라우팅 테이블 A (used nat-01)
### 테이블&연결 pri A_11
resource "aws_route_table" "pri_rtb-a-11" {
  vpc_id = aws_vpc.main.id #VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-01.id
  }
  tags = { Name = "pri-rtb-a" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-a-11" {
  subnet_id      = aws_subnet.pri_A_11.id
  route_table_id = aws_route_table.pri_rtb-a-11.id
}

### 테이블&연결 pri A_12
resource "aws_route_table" "pri_rtb-a-12" {
  vpc_id = aws_vpc.main.id #VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-01.id
  }
  tags = { Name = "pri-rtb-a" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-a-12" {
  subnet_id      = aws_subnet.pri_A_12.id
  route_table_id = aws_route_table.pri_rtb-a-12.id
}

### 테이블&연결 pri A_13
resource "aws_route_table" "pri_rtb-a-13" {
  vpc_id = aws_vpc.main.id #VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-01.id
  }
  tags = { Name = "pri-rtb-a" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-a-13" {
  subnet_id      = aws_subnet.pri_A_13.id
  route_table_id = aws_route_table.pri_rtb-a-13.id
}



################### PRI 라우팅 테이블 C (used nat-02)
### 테이블&연결 pri C_21
resource "aws_route_table" "pri_rtb-c-21" {
  vpc_id = aws_vpc.main.id #VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-02.id
  }
  tags = { Name = "pri-rtb-c" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-c-21" {
  subnet_id      = aws_subnet.pri_C_21.id
  route_table_id = aws_route_table.pri_rtb-c-21.id
}

### 테이블&연결 pri C_22
resource "aws_route_table" "pri_rtb-c-22" {
  vpc_id = aws_vpc.main.id #VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-02.id
  }
  tags = { Name = "pri-rtb-c" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-c-22" {
  subnet_id      = aws_subnet.pri_C_22.id
  route_table_id = aws_route_table.pri_rtb-c-22.id
}


### 테이블&연결 pri C_23
resource "aws_route_table" "pri_rtb-c-23" {
  vpc_id = aws_vpc.main.id #VPC 별칭 입력
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-02.id
  }
  tags = { Name = "pri-rtb-c" } #태그 설정
}
resource "aws_route_table_association" "pri-sub-rtb-c-03" {
  subnet_id      = aws_subnet.pri_C_23.id
  route_table_id = aws_route_table.pri_rtb-c-23.id
}