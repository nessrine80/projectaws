#!/bin/bash

# Exit on any error
set -e

# Print each command (for debug)
set -x

# Full ECR image URI
IMAGE_URI="$ECR_REPO:$IMAGE_TAG"

# Build the Docker image
docker build -t "$IMAGE_URI" .

# Push the image to ECR
docker push "$IMAGE_URI"
echo "done"