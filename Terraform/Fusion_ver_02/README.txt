A) 구성요소
    A-1) VPC: 172.16.0.0/16
            Pub Subent 2개 A(172.16.10.0/24), C(172.16.20.0/24)
            Pri Subnet 6개 A(11~13.0/24), C(21~23.0/24) || NAT 01, 02

    A-2) 인스턴스
            mykey   || 인증키 aws 등록
            bastion || 172.16.10.10 || allow 22 & self IP/32
            master  || 172.16.11.10 || MasterNode_SG
            worker1 || 172.16.11.101|| WorkerNode_SG
            worker2 || 172.16.21.101|| WorkerNode_SG
            * 보안그룹은 추후 EKS 추가 후 수정 예정
    A-3) S3
            mir-s3-test-${var.uptime} || 노드에서 발생하는 로그 수집 목적
            *** tfstate파일 저장을 위한 S3 사전 생성 필요


B) 사용 전 확인사항
    - tfstate파일 저장을 위한 S3 사전 생성 필요

C) 주요 파일 설명
    C-1) firstart.sh
            sh firstart.sh 명령으로 실행
            최초 실행의 경우 사용.
            이후 테라폼 코드 수정 후 적용시 tf apply 명령 진행
            .terraform/이 있는 상황에서 사용시 새 tfstate 생성(main.tf 수정하여 working dir 변경 가능)

            디렉토리 내 mykey 확인, uptime 환경변수 등록 후 tf 릴리즈 진행.

    C-2) destroy.sh
            sh destroy.sh 명령으로 실행
            tf destroy 후 .terraform .terraform.lock.hcl terraform.tfstate 삭제