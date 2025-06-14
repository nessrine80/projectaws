#!/bin/bash
set -e
set -x

# Variables obligatoires.
AWS_ACCOUNT_ID="499845095635"
AWS_REGION="us-east-1"
REPOSITORY_NAME="llm-app"
IMAGE_TAG="${IMAGE_TAG:-latest}"  # fallback to 'latest' if undefined

# Construire l'URI complet de l'image
IMAGE_URI="$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$REPOSITORY_NAME:$IMAGE_TAG"

# Connexion à ECR
aws ecr get-login-password --region "$AWS_REGION" | docker login \
  --username AWS \
  --password-stdin "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"

# Construire et taguer l'image
docker build -t "$IMAGE_URI" .

# Pousser l'image vers ECR
docker push "$IMAGE_URI"
