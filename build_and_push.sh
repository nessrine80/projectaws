#!/bin/bash

set -e

# Config
AWS_REGION="us-east-1"
IMAGE_NAME="llm-app"
IMAGE_TAG=$(git rev-parse --short HEAD)
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
ECR_REGISTRY="$ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com"
FULL_IMAGE="$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG"

echo "🔐 Logging into ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REGISTRY

echo "🐳 Building Docker image..."
docker build -t $IMAGE_NAME .

echo "🏷️ Tagging image..."
docker tag $IMAGE_NAME:latest $FULL_IMAGE

echo "📤 Pushing to ECR..."
docker push $FULL_IMAGE

echo "✅ Image pushed: $FULL_IMAGE"
