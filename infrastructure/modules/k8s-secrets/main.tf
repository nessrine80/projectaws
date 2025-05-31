data "aws_ecr_authorization_token" "token" {}

resource "kubernetes_secret" "ecr_pull_secret" {
  metadata {
    name      = var.secret_name
    namespace = var.namespace
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = base64encode(jsonencode({
      auths = {
        "${var.ecr_registry}" = {
          username = "AWS"
          password = data.aws_ecr_authorization_token.token.authorization_token
          email    = "none@example.com"
        }
      }
    }))
  }
}
