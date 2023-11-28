############################ variable.tf

############ 임시 포트(all)
variable "tempPORT" {
  type = string
}

############ 생성 시간 (export TF_VAR_uptime="-$(date +'%H%M')")
variable "uptime" {
  description = "uptime"
  type        = string
  default     = "$(date +'%H%M')"
}

############ VPC
variable "Pub_net" {
  description = "public subnet A. ip list."
  type        = list(string)
  default     = ["10", "20"]
}
variable "AZz" {
  description = "for NAT."
  type        = list(string)
  default     = ["a", "c"]
}
variable "Pri_net_A" {
  description = "private subnet A. ip list."
  type        = list(string)
  default     = ["11", "12", "13"]
}
variable "Pri_net_C" {
  description = "private subnet A. ip list."
  type        = list(string)
  default     = ["21", "22", "23"]
}


############ K8s 보안그룹
#ssh_port
variable "ssh_port" {
  type = string
}

#k8s_port
variable "k8s_port" {
  type = string
}


############ K8s 마스터&워커
## 워커 AMI
variable "WorkerAMI" {
  type = string
}

## 워커 인스턴스 타입
variable "Worker_instance_type" {
  type = string
}
