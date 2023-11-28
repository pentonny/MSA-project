################### security.tf
### SG (베스천, k8s 마스터, k8s 워커)

# Bastion 보안그룹
resource "aws_security_group" "bastionSG" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # ingress {
  #   from_port   = var.tempPORT
  #   to_port     = var.tempPORT
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  tags = {
    Name = "MIR-Bastion-SG-${var.uptime}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# K8s Master 보안그룹
resource "aws_security_group" "k8s_Master_SG" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = var.tempPORT
    to_port     = var.tempPORT
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = var.k8s_port
    to_port   = var.k8s_port
    protocol  = "tcp"
    self      = true # 자신을 소스로 지정
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MIR-k8s_Master-SG"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# K8s Worker 보안그룹
resource "aws_security_group" "k8s_Worker_SG" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = var.tempPORT
    to_port     = var.tempPORT
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MIR-k8s_Worker-SG"
  }

  lifecycle {
    create_before_destroy = true
  }
}