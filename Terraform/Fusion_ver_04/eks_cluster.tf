resource "aws_eks_cluster" "test-eks" {
  name     = "test-eks"
  version  = "1.27"
  role_arn = aws_iam_role.test-cluster-role.arn
  vpc_config {
    subnet_ids = [aws_subnet.pri_A[0].id, aws_subnet.pri_C[0].id]
  }
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
    aws_iam_role_policy_attachment.example-AmazonEBSCSIDriverPolicy,
  ]
}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.test-eks.name
  addon_name   = "coredns"
}

resource "aws_eks_addon" "kube-proxy" {
  cluster_name = aws_eks_cluster.test-eks.name
  addon_name   = "kube-proxy"
}

resource "aws_eks_addon" "vpc-cni" {
  cluster_name = aws_eks_cluster.test-eks.name
  addon_name   = "vpc-cni"
}

resource "aws_eks_addon" "efs-csi" {
  cluster_name = aws_eks_cluster.test-eks.name
  addon_name   = "aws-efs-csi-driver"
}