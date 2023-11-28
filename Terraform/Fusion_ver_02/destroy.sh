#!/bin/bash
# 배포된 테라폼 환경 정리 후 .terraform 등 잔여 리소스 삭제
echo "배포된 테라폼 환경 정리 후 .terraform 등 잔여 리소스 삭제"

# 테라폼 인프라 종료
echo "테라폼 종료(자동응답)"
terraform destroy -auto-approve

# 잔여 리소스 삭제
echo "잔여 리소스 삭제"
sudo rm -rf .terraform .terraform.lock.hcl terraform.tfstate