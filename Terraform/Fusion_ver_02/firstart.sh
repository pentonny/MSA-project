#!/bin/bash

### git clone 이후 테라폼 최초 배포시 사용을 권장합니다 ###

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

### <uptime 변수 초기화 및 재입력>
echo "[초기화]uptime 변수값"
sed -i '/^uptime\s*=/d' terraform.tfvars
echo "uptime 변수값 입력"
export uptime="$(date +'%H%M')"
export TF_VAR_uptime="$(date +'%H%M')"; 
echo "uptime = $TF_VAR_uptime" >> terraform.tfvars;
sed -i "s|key.*|key     = \"TEST-${uptime}/terraform.tfstate\"|" main.tf;
cat terraform.tfvars | tail -n 1;
echo "background $(grep 'bucket =' main.tf)"
### </uptime 변수 초기화 및 재입력>


### <.terraform/ 체크>
if [ -d ".terraform" ]; then
	read -p ".terraform is exists. Do you want to continue? (Y/N): " choice
		case "$choice" in
			[Yy])
				echo "TF init -migrate-state"; terraform init -migrate-state;
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
		echo "TF init"; terraform init;
fi
### </.terraform/ 체크>

### 배포 진행
# apply
terraform fmt;
terraform apply -auto-approve;


### 삭제[각주 해제 금지] echo "TF destroy"; terraform destroy -auto-approve;