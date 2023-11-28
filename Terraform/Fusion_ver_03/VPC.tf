################### VPC.tf
### VPC, IGW

##### VPC 생성
resource "aws_vpc" "main" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "MIR_vpc-${var.uptime}"
  }
}

##### IGW 생성
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MIR_igw"
  }
}