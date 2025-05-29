#!/bin/bash
set -e

echo "🔨 Building Docker image from ./app..."
docker build -t "$ECR_REPO:$IMAGE_TAG" .

echo "📦 Target ECR: $ECR_REPO"

echo "📤 Pushing image to ECR..."
docker push "$ECR_REPO:$IMAGE_TAG"

echo "✅ Image pushed: $ECR_REPO:$IMAGE_TAG"

# Optionally export for future steps
echo "IMAGE_URI=$ECR_REPO:$IMAGE_TAG" >> $GITHUB_ENV
