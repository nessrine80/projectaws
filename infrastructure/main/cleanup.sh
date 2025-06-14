#!/bin/bash

set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <vpc-id>"
  exit 1
fi

VPC_ID=$1

echo "🚀 Début du nettoyage du VPC $VPC_ID ..."

echo "1️⃣ Suppression des Elastic IPs non attachées dans le VPC $VPC_ID ..."
aws ec2 describe-addresses --query "Addresses[?NetworkInterfaceId==null && VpcId=='$VPC_ID'].AllocationId" --output text | \
xargs -r -n1 aws ec2 release-address --allocation-id

echo "2️⃣ Suppression des Load Balancers liés au VPC $VPC_ID ..."
LB_NAMES=$(aws elb describe-load-balancers --query "LoadBalancerDescriptions[?VPCId=='$VPC_ID'].LoadBalancerName" --output text)
for lb in $LB_NAMES; do
  echo "Suppression du Load Balancer : $lb"
  aws elb delete-load-balancer --load-balancer-name "$lb"
done

echo "3️⃣ Suppression des interfaces réseau non attachées au VPC $VPC_ID ..."
ENI_IDS=$(aws ec2 describe-network-interfaces --filters "Name=vpc-id,Values=$VPC_ID" --query "NetworkInterfaces[?Attachment==null].NetworkInterfaceId" --output text)
for eni in $ENI_IDS; do
  echo "Suppression de l'interface réseau $eni"
  aws ec2 delete-network-interface --network-interface-id "$eni"
done

echo "4️⃣ Suppression du VPC $VPC_ID ..."
aws ec2 delete-vpc --vpc-id "$VPC_ID"

echo "✅ Nettoyage terminé pour le VPC $VPC_ID"
