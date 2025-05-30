#!/bin/bash
set -euo pipefail

VPC_ID="vpc-0547fcb17d185a137"
REGION="us-east-1" # Modifie si nécessaire

echo "➡️ Suppression des NAT Gateways..."
for nat in $(aws ec2 describe-nat-gateways --region $REGION --filter Name=vpc-id,Values=$VPC_ID --query 'NatGateways[].NatGatewayId' --output text); do
  aws ec2 delete-nat-gateway --region $REGION --nat-gateway-id $nat
  echo "⏳ Attente de la suppression du NAT Gateway: $nat"
  aws ec2 wait nat-gateway-deleted --region $REGION --nat-gateway-ids $nat
done

echo "➡️ Suppression des interfaces réseau..."
for eni in $(aws ec2 describe-network-interfaces --region $REGION --filters Name=vpc-id,Values=$VPC_ID --query 'NetworkInterfaces[].NetworkInterfaceId' --output text); do
  aws ec2 delete-network-interface --region $REGION --network-interface-id $eni || true
done

echo "➡️ Suppression des sous-réseaux..."
for subnet in $(aws ec2 describe-subnets --region $REGION --filters Name=vpc-id,Values=$VPC_ID --query 'Subnets[].SubnetId' --output text); do
  aws ec2 delete-subnet --region $REGION --subnet-id $subnet
done

echo "➡️ Suppression des Internet Gateways..."
for igw in $(aws ec2 describe-internet-gateways --region $REGION --filters Name=attachment.vpc-id,Values=$VPC_ID --query 'InternetGateways[].InternetGatewayId' --output text); do
  aws ec2 detach-internet-gateway --region $REGION --internet-gateway-id $igw --vpc-id $VPC_ID
  aws ec2 delete-internet-gateway --region $REGION --internet-gateway-id $igw
done

echo "➡️ Suppression des tables de routage..."
for rtb in $(aws ec2 describe-route-tables --region $REGION --filters Name=vpc-id,Values=$VPC_ID --query 'RouteTables[].RouteTableId' --output text); do
  aws ec2 delete-route-table --region $REGION --route-table-id $rtb || true
done

echo "➡️ Suppression des Security Groups..."
for sg in $(aws ec2 describe-security-groups --region $REGION --filters Name=vpc-id,Values=$VPC_ID --query 'SecurityGroups[?GroupName!=`default`].GroupId' --output text); do
  aws ec2 delete-security-group --region $REGION --group-id $sg
done

echo "➡️ Suppression du VPC..."
aws ec2 delete-vpc --region $REGION --vpc-id $VPC_ID

echo "✅ Nettoyage terminé."
