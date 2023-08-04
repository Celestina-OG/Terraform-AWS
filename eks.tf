# Resource: aws_iam_role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

resource "aws_iam_role" "eks_cluster" {
  # The name of the role 
  name = "eks-cluster"

  # This policy grants an entity permission to assume the role.
  # EKS assumes the role to create AWS resources for kubernetes cluster.
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  # The ARN of the policy you want to apply
  # https://docs.aws.amazon.com/aws-managed-policy/latest/reference/AmazonEKSClusterPolicy.html#AmazonEKSClusterPolicy-json
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The role the policy should be applied to 
  role = aws_iam_role.eks_cluster.name

}

# Resource: aws_eks_cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

resource "aws_eks_cluster" "eks" {
  # Name of cluster
  name = "eks"

  # The ARN of the IAM role that provides permissions for the kubenetes 
  #control plane to make calla to AWS API 
  role_arn = aws_iam_role.eks_cluster.arn

  # (Optional) Desired kubernetes master version
  version = "1.26"

  vpc_config {
    # Indicates whether or not EKS private API server endpoint is enabled
    endpoint_private_access = false

    # Indicates whether or not EKS public API server endpoint is enabled
    endpoint_public_access = true

    # Must be in at least two different AZ
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
  }

  # "depends_on" ensures that the IAM Role persmissions are greated before and deleted after EKS Cluster
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure 
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}
