output "cluster_id" {
  value       = aws_eks_cluster.eks.id
  description = "EKS Cluster ID"
}

output "cluster_arn" {
  value       = aws_eks_cluster.eks.arn
  description = "EKS Cluster ARN"
}

output "cluster_name" {
  value       = aws_eks_cluster.eks.name
  description = "EKS Cluster name"
}

output "cluster_endpoint" {
  value       = aws_eks_cluster.eks.endpoint
  description = "EKS API endpoint"
}

output "cluster_certificate_authority_data" {
  value       = aws_eks_cluster.eks.certificate_authority[0].data
  description = "Cluster CA cert (base64)"
}

output "oidc_issuer_url" {
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
  description = "OIDC issuer URL"
}

output "primary_security_group_id" {
  value       = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
  description = "Primary EKS SG ID"
}

output "node_group_id" {
  value       = aws_eks_node_group.public.id
  description = "Node group ID"
}

output "node_group_status" {
  value       = aws_eks_node_group.public.status
  description = "Node group status"
}

output "node_group_version" {
  value       = aws_eks_node_group.public.version
  description = "Node group Kubernetes version"
}
