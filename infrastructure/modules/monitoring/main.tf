provider "helm" {
  kubernetes {
    config_path = var.kubeconfig_path
  }
}

provider "kubernetes" {
  config_path = var.kubeconfig_path
}

resource "kubernetes_config_map" "grafana_dashboards" {
  metadata {
    name      = "grafana-dashboards"
    namespace = var.namespace
    labels = {
      grafana_dashboard = "1"
    }
  }

  data = {
    "eks-cluster-dashboard.json" = file("${path.module}/dashboards/eks-cluster-dashboard.json")
  }
}

resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = true

  values = [
    file("${path.module}/values/prometheus-values.yaml")
  ]

  timeout           = 1800
  atomic            = false
  cleanup_on_fail   = true
  dependency_update = true

  depends_on = [kubernetes_config_map.grafana_dashboards]
}
