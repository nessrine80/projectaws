output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.eks.id
}

output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate" {
  description = "The EKS cluster certificate"
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

output "node_group_id" {
  description = "EKS Node Group ID"
  value       = aws_eks_node_group.eks_nodes.id
}

output "node_group_status" {
  description = "EKS Node Group Status"
  value       = aws_eks_node_group.eks_nodes.status
}

output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = aws_eks_cluster.eks.arn
}

output "cluster_certificate_authority_data" {
  description = "Cluster CA data"
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

output "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL"
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

output "node_group_public_id" {
  description = "Node group name"
  value       = aws_eks_node_group.eks_nodes.node_group_name
}
