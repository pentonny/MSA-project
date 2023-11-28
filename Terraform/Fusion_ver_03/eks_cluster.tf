resource "aws_eks_cluster" "test-eks" {
  name     = "test-eks"
  version  = "1.27"
  role_arn = aws_iam_role.test-cluster-role.arn
  vpc_config {
    subnet_ids = [aws_subnet.pri_A_11.id, aws_subnet.pri_C_21.id]
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}