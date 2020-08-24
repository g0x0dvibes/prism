#!/bin/bash
# at some point, should really replace with jq usage. it's pretty wonky
PRISM_AMI_ID=$(cat current_ami.txt)
sed -i "s/ami-.*/$PRISM_AMI_ID\"/g" terraform/variables.tf
HOME_IP=$(curl https://checkip.amazonaws.com/)
sed -i "s/0.0.0.0\/0/$HOME_IP\/32/g" terraform/variables.tf
# sed "s/0.0.0.0\/0/$HOME_IP\/32/g" terraform/variables.tf

cd terraform/
terraform init
terraform apply