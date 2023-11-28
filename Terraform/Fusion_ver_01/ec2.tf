################### ec2.tf
### 키페어, 베스천(+eip), k8s마스터, k8s워커

# 키페어
resource "aws_key_pair" "mykey" {
  key_name   = "mykey-${var.uptime}"
  public_key = file("mykey.pub")
}

### 베스천 (172.16.10.10)
resource "aws_instance" "bastion" {
  ami                    = "ami-0c9c942bd7bf113a2" # Ubuntu22.04
  instance_type          = "t3.large"
  vpc_security_group_ids = [aws_security_group.bastionSG.id]
  subnet_id              = aws_subnet.pub_A_10.id
  private_ip             = "172.16.10.10"

  # 키페어 지정
  key_name = aws_key_pair.mykey.key_name

  tags = {
    Name = "MIR-Bastion-${var.uptime}"
  }
}
### EIP for 베스천
resource "aws_eip" "bastion-EIP" {
  domain   = "vpc"
  instance = aws_instance.bastion.id

  tags = {
    Name = "MIR-bastion-eip"
  }
}

### k8s 마스터 (172.16.11.10)
resource "aws_instance" "masternode" {
  ami                    = "ami-0c9c942bd7bf113a2" # Ubuntu22.04
  instance_type          = "t3.large"
  vpc_security_group_ids = [aws_security_group.k8s_Master_SG.id]
  subnet_id              = aws_subnet.pri_A_11.id
  private_ip             = "172.16.11.10"

  # EC2 - S3 연결
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name

  #키페어
  key_name = aws_key_pair.mykey.key_name

  #user_data              = file("${path.module}/userdata.sh")

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "MIR-k8s_Master"
  }
}

### k8s 워커 (A, C)
# k8s 워커 A (172.16.11.101)
resource "aws_instance" "workernode1" {
  ami                    = var.WorkerAMI
  instance_type          = var.Worker_instance_type
  vpc_security_group_ids = [aws_security_group.k8s_Worker_SG.id]
  subnet_id              = aws_subnet.pri_A_11.id
  private_ip             = "172.16.11.101"

  # 키페어 지정
  key_name = aws_key_pair.mykey.key_name

  # EC2 - S3 연결
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name

  tags = {
    Name = "MIR-A-Worker"
  }
}


# k8s 워커 C (172.16.21.101)
resource "aws_instance" "workernode2" {
  ami                    = var.WorkerAMI
  instance_type          = var.Worker_instance_type
  vpc_security_group_ids = [aws_security_group.k8s_Worker_SG.id]
  subnet_id              = aws_subnet.pri_C_21.id
  private_ip             = "172.16.21.101"

  # 키페어 지정
  key_name = aws_key_pair.mykey.key_name

  # EC2 - S3 연결
  iam_instance_profile = aws_iam_instance_profile.ec2_s3_profile.name

  tags = {
    Name = "MIR-C-Worker"
  }
}
