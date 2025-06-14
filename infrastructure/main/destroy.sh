#!/bin/bash


set -euo pipefail

# Variables
ENV=${1:-default}
TFVARS_FILE="terraform.tfvars"
WORKDIR="$(dirname "$0")"

# Entrer dans le dossier yes
cd "$WORKDIR"

echo "🔁 Initialisation de Terraform..."
terraform init -input=false

echo "🔍 Planification de l'infrastructure..."
terraform plan -var-file="$TFVARS_FILE" -out=tfplan.out

echo "🚀 Application de l'infrastructure..."
terraform apply -input=false tfplan.out

echo "✅ Déploiement terminé."