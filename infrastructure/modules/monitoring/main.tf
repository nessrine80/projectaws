resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_config_map" "grafana_dashboards" {
  metadata {
    name      = "grafana-dashboards"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
    labels = {
      grafana_dashboard = "1"
    }
  }

  data = {
    "eks-cluster-dashboard.json" = file("${path.module}/dashboards/eks-cluster-dashboard.json")
  }

  depends_on = [kubernetes_namespace.monitoring]
}

resource "helm_release" "kube_prometheus_stack" {
  name             = "kube-prometheus-stack"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = var.namespace
  version          = var.chart_version
  create_namespace = false # car le namespace est déjà créé manuellement

  values = [
    file("${path.module}/values/prometheus-values.yaml")
  ]

  timeout           = 1800
  atomic            = false
  cleanup_on_fail   = true
  dependency_update = true

  depends_on = [
    kubernetes_namespace.monitoring,
    kubernetes_config_map.grafana_dashboards
  ]
}
