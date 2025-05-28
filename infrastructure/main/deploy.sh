#!/bin/bash

set -e

echo "🔧 Initialisation Terraform..."
cd infrastructure || exit 1
terraform init -input=false

echo "💣 Destroy Terraform..."
terraform destroy -auto-approve