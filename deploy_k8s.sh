#!/bin/bash

set -e

# Config
AWS_REGION="us-east-1"
CLUSTER_NAME="MyCluster"
NAMESPACE="default"
IMAGE_NAME="llm-app"
IMAGE_TAG=$(git rev-parse --short HEAD)
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
IMAGE_URL="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$IMAGE_TAG"

# 1. Authentifie kubectl à EKS
echo "🔐 Authentification à EKS..."
aws eks --region $AWS_REGION update-kubeconfig --name $CLUSTER_NAME

# 2. Applique le manifest avec image dynamique
echo "🚀 Déploiement de l'application avec l'image : $IMAGE_URL"

# On remplace dynamiquement l'image dans le manifest et on applique
envsubst < deployment.yaml | kubectl apply -n $NAMESPACE -f -

echo "✅ Déploiement terminé avec succès."
