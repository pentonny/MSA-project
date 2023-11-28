module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.17.2"

  cluster_name    = "eks_test"
  cluster_version = "1.27"
  vpc_id          = aws_vpc.main.id
  subnet_ids      = [aws_subnet.pri_A[0].id, aws_subnet.pri_C[0].id]
  eks_managed_node_groups = {
    default_node_group = {
      min_size       = 2
      max_size       = 3
      desired_size   = 2
      instance_types = ["t3.large"]
    }
  }

  tags = {
    Environment = "dev"
  }
}