#!/bin/bash

set -e

echo "🔧 Initialisation Terraform..."
terraform init -input=false

echo "📋 Plan Terraform..."
terraform plan -out=tfplan

echo "🚀 Apply Terraform..."
terraform apply -auto-approve tfplan
