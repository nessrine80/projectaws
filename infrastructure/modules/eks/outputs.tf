output "cluster_name" {
  value       = aws_eks_cluster.eks.name
  description = "EKS Cluster Name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "EKS API Server Endpoint"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.eks.certificate_authority[0].data
  description = "Base64 encoded CA data"
}

output "node_group_name" {
  value       = aws_eks_node_group.public.node_group_name
  description = "Name of the node group"
}

output "node_group_status" {
  value       = aws_eks_node_group.public.status
  description = "Status of the node group"
}
