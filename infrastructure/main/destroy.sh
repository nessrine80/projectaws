#!/bin/bash
set -e

echo "🧹 Nettoyage du dépôt ECR..."
IMAGE_IDS=$(aws ecr list-images --repository-name "$ECR_REPO_NAME" --region "$AWS_DEFAULT_REGION" --query 'imageIds[*]' --output json)

if [[ "$IMAGE_IDS" != "[]" ]]; then
  aws ecr batch-delete-image --repository-name "$ECR_REPO_NAME" --region "$AWS_DEFAULT_REGION" --image-ids "$IMAGE_IDS"
else
  echo "✅ Aucun tag à supprimer."
fi

echo "🧨 Destruction de l'infrastructure Terraform..."
terraform init
terraform destroy --auto-approve
