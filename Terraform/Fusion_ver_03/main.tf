################### main.tf
### provider(TF, AWS)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  //profile = "tf-user"
  region = "ap-northeast-2" # Asia Pacific (Seoul) region
}