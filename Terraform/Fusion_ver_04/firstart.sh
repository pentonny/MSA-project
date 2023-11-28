#!/bin/bash

### git clone 이후 테라폼 최초 배포시 사용을 권장합니다 ###
#.terraform/ 체크
if [ -d ".terraform" ]; then
	read -p ".terraform is exists. Do you want to continue? (Y/N): " choice
		case "$choice" in
			[Yy])
				echo "Terraform apply -auto-approve"
				;;
			[Nn])
				echo "Exiting..."
				exit 1
				;;
			*)
				echo "Invalid choice. Exiting..."
				exit 1
				;;
		esac
	else
		echo "Terraform apply -auto-approve"
fi

### <KTS 시간 동기화>
echo "time check"
sudo ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
date
### </KTS 시간 동기화>

### <키페어 체크>
echo "Check mykey"
if [ -f "mykey" ] && [ -f "mykey.pub" ]; then
  ls | grep my
  echo "already key pairs. next process"
else
  echo "create mykey"
  ssh-keygen -m PEM -f mykey -N ""
  ls | grep my
fi
### </키페어 체크>
sed -i '/^uptime\s*=/d' terraform.tfvars
terraform init
export TF_VAR_uptime="$(date +'%H%M')";echo "uptime = $TF_VAR_uptime" >> terraform.tfvars; cat terraform.tfvars | tail 1
terraform fmt
terraform apply -auto-approve;
