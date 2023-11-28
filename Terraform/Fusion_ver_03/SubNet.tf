################### SubNet.tf
### Pub 서브넷[A(10), C(20)], Pir 서브넷[A(11~13), C(21~23)]

################### PUB-서브넷(A, C for Bastion)
# Bastion

# 퍼블릭_A
resource "aws_subnet" "pub_A_10" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "true"

  tags = {
    Name                     = "MIR-subnet-PUB-A-${var.uptime}"
    type                     = "public"
    "kubernetes.io/role/elb" = 1
  }
}

# 퍼블릭_A
resource "aws_subnet" "pub_C_10" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.20.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "true"

  tags = {
    Name                     = "MIR-subnet-PUB-C"
    type                     = "public"
    "kubernetes.io/role/elb" = 1
  }
}

################### PRI-서브넷 A(11, 12, 13)
# k8s (master, worker)

# 프라이빗_A11
resource "aws_subnet" "pri_A_11" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.11.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-A11-${var.uptime}"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# 프라이빗_A12
resource "aws_subnet" "pri_A_12" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.12.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-A12"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}

# 프라이빗_A13
resource "aws_subnet" "pri_A_13" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.13.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-A13"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}


################### PRI-서브넷 C(21, 22, 23)
# k8s (worker)
#프라이빗_C21
resource "aws_subnet" "pri_C_21" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.21.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-C21-${var.uptime}"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}

#프라이빗_C22
resource "aws_subnet" "pri_C_22" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.22.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-C22"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}

#프라이빗_C23
resource "aws_subnet" "pri_C_23" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.23.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-C23"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}
