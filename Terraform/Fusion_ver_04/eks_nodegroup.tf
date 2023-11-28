resource "aws_eks_node_group" "test-nodeg" {
  cluster_name    = aws_eks_cluster.test-eks.name
  node_group_name = "test-node-group"
  node_role_arn   = aws_iam_role.test-node-role.arn
  subnet_ids      = [aws_subnet.pri_A[0].id, aws_subnet.pri_C[0].id]
  scaling_config {
    desired_size = 2
    max_size     = 4
    min_size     = 2
  }
  update_config {
    max_unavailable = 1
  }
  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}