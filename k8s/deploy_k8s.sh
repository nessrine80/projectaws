#!/bin/bash
set -e

echo "📦 Getting latest image tag..."

REPO_NAME="llm-app"
REGION="us-east-1"
ACCOUNT_ID="499845095635"

# Récupère le dernier tag (optionnel, selon ta logique)
TAG=$(aws ecr describe-images \
  --repository-name "$REPO_NAME" \
  --region "$REGION" \
  --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]' \
  --output text)

echo "🖼️  Using image tag: $TAG"

# Applique les YAML
kubectl apply -f deployment.yml
kubectl apply -f svc.yml
#
