output "ecr_pull_secret_name" {
  value = kubernetes_secret.ecr_pull_secret.metadata[0].name
}
