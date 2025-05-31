#!/bin/bash
set -euxo pipefail

echo "� Nettoyage des volumes Kubernetes..."
sudo rm -rf /var/lib/kubelet/pods/*/volumes/* || true

echo "� Nettoyage des journaux système de plus de 1 jour..."
sudo journalctl --vacuum-time=1d || true

echo "�� Suppression des images containerd non utilisées..."
sudo ctr -n k8s.io images ls | awk 'NR>1 {print $1}' | xargs -r sudo ctr -n k8s.io images rm || true

echo "� Redémarrage de kubelet..."
sudo systemctl restart kubelet

echo "✅ Nettoyage terminé."
