#!/bin/bash
PRISM_AMI_ID=$(cat current_ami.txt 1>&2)
sed -i "s/ami-.*/$PRISM_AMI_ID\"/g" terraform/variables.tf
HOME_IP=$(curl https://checkip.amazonaws.com/ 1>&2)
sed -i "s/0.0.0.0\/0/$HOME_IP\/32/g" terraform/variables.tf

cd terraform/
terraform init
terraform apply