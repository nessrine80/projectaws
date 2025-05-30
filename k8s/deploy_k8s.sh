#!/bin/bash
set -e

echo "📦 Getting latest image tag..."
TAG=$(aws ecr describe-images \
  --repository-name "mon-app" \
  --region "eu-west-1" \
  --query 'sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]' \
  --output text)

IMAGE_URI="${AWS_ACCOUNT_ID}.dkr.ecr.eu-west-1.amazonaws.com/${AWS_ACCOUNT_ID}:$TAG"
echo "Using image: $IMAGE_URI"

echo "📝 Updating manifest..."
sed -i "s|image:.*|image: $IMAGE_URI|" deployment.yml
cat deployment.yml

echo "🚀 Deploying to Kubernetes..."
kubectl apply -f deployment.yml
kubectl apply -f svc.yml
kubectl apply -f ingress.yml

