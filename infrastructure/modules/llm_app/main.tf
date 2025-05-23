provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_deployment" "llm" {
  metadata {
    name = "llm-app"
    labels = {
      app = "llm"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "llm"
      }
    }
    template {
      metadata {
        labels = {
          app = "llm"
        }
      }
      spec {
        container {
          name  = "llm"
          image = var.image_url

          port {
            container_port = 8080
          }

          resources {
            limits = {
              memory = "256Mi"
              cpu    = "250m"
            }
            requests = {
              memory = "128Mi"
              cpu    = "100m"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "llm" {
  metadata {
    name = "llm-service"
  }

  spec {
    selector = {
      app = "llm"
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}
