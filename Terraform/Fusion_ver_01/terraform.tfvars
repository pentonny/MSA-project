######################## terraform.tf

#ec2
tempPORT = 0
ssh_port = 22
k8s_port = 6443

##### k8s 워커 설정
WorkerAMI            = "ami-0c9c942bd7bf113a2" # Ubuntu22.04
Worker_instance_type = "t3.large"
