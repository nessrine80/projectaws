#!/bin/bash

set -euo pipefail

echo "🧨 Initialisation de Terraform..."
terraform init -reconfigure

echo "📦 Suppression manuelle des Elastic IPs restantes..."
EIPS=$(aws ec2 describe-addresses --query "Addresses[*].AllocationId" --output text)

if [[ -n "$EIPS" ]]; then
  for eip in $EIPS; do
    echo "🧹 Libération de l'EIP : $eip"
    aws ec2 release-address --allocation-id "$eip"
  done
else
  echo "✅ Aucune EIP à libérer."
fi

echo "🧨 Terraform destroy en cours..."
terraform destroy -var-file="terraform.tfvars" -auto-approve

echo "✅ Infrastructure détruite avec succès."
