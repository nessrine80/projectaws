#!/bin/bash
set -e

echo "➕ Adding Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "📦 Installing Prometheus stack..."
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace

echo "📦 Installing Grafana..."
helm install grafana grafana/grafana \
  --namespace monitoring

echo "🔧 Patching Grafana service to LoadBalancer..."
kubectl patch svc prometheus-grafana \
  -n monitoring \
  --type merge \
  -p '{
    "spec": {
      "type": "LoadBalancer",
      "ports": [
        {
          "name": "http",
          "protocol": "TCP",
          "port": 80,
          "targetPort": 3000
        }
      ]
    }
  }'

echo "🔐 Retrieving Grafana admin password..."
kubectl get secret --namespace monitoring prometheus-grafana \
  -o jsonpath="{.data.admin-password}" | base64 --decode && echo

echo "📡 Installing Kubernetes Metrics Server..."
kubectl apply -f https://raw.githubusercontent.com/techiescamp/kubeadm-scripts/main/manifests/metrics-server.yaml

echo "✅ Monitoring stack deployed successfully."
