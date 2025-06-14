#!/bin/bash

echo "⚠️  Destruction de l'infrastructure Terraform en cours..."

# Étape 1 : Initialiser Terraform si nécessaire
terraform init

# Étape 2 : Afficher le plan de destruction
terraform plan -destroy

# Étape 3 : Appliquer la destruction
terraform destroy -auto-approve

echo "✅ Infrastructure détruite."
