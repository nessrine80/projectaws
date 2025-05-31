#!/bin/bash

# Remplace cette liste par les VPCs à supprimer
VPC_IDS=("vpc-0580713b92563dac9" "vpc-0a8bd9ade215a7df6")
REGION="us-east-1"

for VPC_ID in "${VPC_IDS[@]}"; do
  echo "🔧 Suppression du VPC : $VPC_ID"

  # Supprimer les interfaces réseau
  for eni in $(aws ec2 describe-network-interfaces --filters Name=vpc-id,Values=$VPC_ID --query "NetworkInterfaces[*].NetworkInterfaceId" --output text --region $REGION); do
    echo "🧹 Suppression ENI : $eni"
    aws ec2 delete-network-interface --network-interface-id $eni --region $REGION
  done

  # Détacher et supprimer les Internet Gateways
  for igw in $(aws ec2 describe-internet-gateways --filters Name=attachment.vpc-id,Values=$VPC_ID --query "InternetGateways[*].InternetGatewayId" --output text --region $REGION); do
    echo "🔌 Détachement et suppression IGW : $igw"
    aws ec2 detach-internet-gateway --internet-gateway-id $igw --vpc-id $VPC_ID --region $REGION
    aws ec2 delete-internet-gateway --internet-gateway-id $igw --region $REGION
  done

  # Supprimer les NAT Gateways
  for nat in $(aws ec2 describe-nat-gateways --filter Name=vpc-id,Values=$VPC_ID --query "NatGateways[*].NatGatewayId" --output text --region $REGION); do
    echo "🧨 Suppression NAT Gateway : $nat"
    aws ec2 delete-nat-gateway --nat-gateway-id $nat --region $REGION
  done

  # Supprimer les route tables (sauf main)
  for rtb in $(aws ec2 describe-route-tables --filters Name=vpc-id,Values=$VPC_ID --query "RouteTables[*].RouteTableId" --output text --region $REGION); do
    echo "🚧 Suppression Route Table : $rtb"
    aws ec2 delete-route-table --route-table-id $rtb --region $REGION || true
  done

  # Supprimer les subnets
  for subnet in $(aws ec2 describe-subnets --filters Name=vpc-id,Values=$VPC_ID --query "Subnets[*].SubnetId" --output text --region $REGION); do
    echo "🗺️ Suppression Subnet : $subnet"
    aws ec2 delete-subnet --subnet-id $subnet --region $REGION
  done

  # Supprimer les security groups (sauf default)
  for sg in $(aws ec2 describe-security-groups --filters Name=vpc-id,Values=$VPC_ID --query "SecurityGroups[*].GroupId" --output text --region $REGION); do
    if [[ "$sg" != *"default"* ]]; then
      echo "🛡️ Suppression Security Group : $sg"
      aws ec2 delete-security-group --group-id $sg --region $REGION
    fi
  done

  # Supprimer le VPC
  echo "🔥 Suppression finale du VPC : $VPC_ID"
  aws ec2 delete-vpc --vpc-id $VPC_ID --region $REGION
  echo "✅ VPC $VPC_ID supprimé avec succès !"
done
