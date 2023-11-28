################### SubNet.tf
### Pub 서브넷[A(10), C(20)], Pir 서브넷[A(11~13), C(21~23)]

################### PUB-서브넷(A, C for Bastion)
# Bastion

# 퍼블릭_A 10, C 20
resource "aws_subnet" "pub" {
  count                   = length(var.Pub_net) # ip 대역
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.${var.Pub_net[count.index]}.0/24"
  availability_zone       = "ap-northeast-2${var.AZz[count.index]}"
  map_public_ip_on_launch = "true"

  tags = {
    Name                     = "MIR-subnet-PUB-${var.AZz[count.index]}"
    type                     = "public"
    "kubernetes.io/role/elb" = 1
  }
}

################### PRI-서브넷 A(11, 12, 13)
# EKS (master, worker)
# 프라이빗_A
resource "aws_subnet" "pri_A" {
  count                   = length(var.Pri_net_A)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.${var.Pri_net_A[count.index]}.0/24"
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-A-${var.Pri_net_A[count.index]}"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}


################### PRI-서브넷 C(21, 22, 23)
# EKS (worker)
#프라이빗_C
resource "aws_subnet" "pri_C" {
  count                   = length(var.Pri_net_C)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "172.16.${var.Pri_net_C[count.index]}.0/24"
  availability_zone       = "ap-northeast-2c"
  map_public_ip_on_launch = "false"

  tags = {
    Name                              = "MIR-subnet-PRI-C-${var.Pri_net_C[count.index]}"
    type                              = "private"
    "kubernetes.io/role/internal-elb" = 1
  }
}