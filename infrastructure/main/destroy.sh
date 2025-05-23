#!/bin/bash

set -euo pipefail

echo "🧨 Terraform destroy en cours..."

terraform destroy -var-file="terraform.tfvars" -auto-approve

echo "✅ Infrastructure détruite avec succès."

