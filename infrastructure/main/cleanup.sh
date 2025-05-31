#!/bin/bash
set -euxo pipefail

echo "í·¹ Nettoyage des volumes Kubernetes..."
sudo rm -rf /var/lib/kubelet/pods/*/volumes/* || true

echo "í·¼ Nettoyage des journaux systÃ¨me de plus de 1 jour..."
sudo journalctl --vacuum-time=1d || true

echo "ï¿½ï¿½ Suppression des images containerd non utilisÃ©es..."
sudo ctr -n k8s.io images ls | awk 'NR>1 {print $1}' | xargs -r sudo ctr -n k8s.io images rm || true

echo "í´ RedÃ©marrage de kubelet..."
sudo systemctl restart kubelet

echo "âœ… Nettoyage terminÃ©."
