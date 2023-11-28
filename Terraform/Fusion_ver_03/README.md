깃 클론 하기
```
git clone https://github.com/2MIRACLE-BTC/2MIR-FP.git
```
main.tf 파일 수정하기
```
cd main.tf
```
provider "aws" {
  //profile = "tf-user"  ##주석처리 해제
  region = "ap-northeast-2" # Asia Pacific (Seoul) region
}
terraform 파일 실행
```
sh first.sh
```
pem Key 다운로드 후 Bastion으로 접속하기
```
aws configure
```
```
aws eks update-kubeconfig --region ap-northeast-2 --name test-eks
```
