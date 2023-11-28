resource "aws_s3_bucket" "MIR_S3" {
  bucket = "mir-s3-test-${var.uptime}" # 소문자, 하이픈만 사용가능

  tags = {
    Name        = "MIR-s3-test"
    Environment = "Dev"
  }
}

# S3 버킷에 접근 권한을 부여하는 IAM 정책
resource "aws_iam_policy" "s3_full_access" {
  name        = "S3FullAccess"
  description = "Provides full access to S3"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Action": ["s3:*"],
    "Resource": "*"
  }]
}
EOF
}

# EC2 인스턴스용 IAM 역할 생성
resource "aws_iam_role" "ec2_s3_role" {
  name               = "EC2S3Role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": {"Service": "ec2.amazonaws.com"},
    "Action": "sts:AssumeRole"
  }]
}
EOF
}

# IAM 역할에 정책 연결
resource "aws_iam_role_policy_attachment" "ec2_s3_attach" {
  role       = aws_iam_role.ec2_s3_role.name
  policy_arn = aws_iam_policy.s3_full_access.arn
}

# IAM 인스턴스 프로필 생성
resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "EC2S3Profile"
  role = aws_iam_role.ec2_s3_role.name
}
