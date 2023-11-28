깃 클론 하기
```
git clone https://github.com/2MIRACLE-BTC/2MIR-FP.git
```
main.tf 파일 수정하기 \
tf-user와 s3 버킷 수정하기
```
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # tfstate파일 저장 위치 설정 | terraform init -migrate-state
  backend "s3" {
    region  = "ap-northeast-2"
    bucket  = "terraform-backend-park" # 미리 생성한 S3 이름 작성
    encrypt = true             # tfstate파일 암호화 설정
    # tfstate 저장 경로
    key = "TEST-0902/terraform.tfstate"
  }
}
```
terraform 파일 실행
```
sh firstart.sh
```
pem Key 다운로드 후 Bastion으로 접속하기
```
aws configure
```
```
aws eks update-kubeconfig --region ap-northeast-2 --name test-eks
```
