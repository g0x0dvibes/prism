#!/bin/bash
if [ -f "logs/packer_output.txt"]; then
    rm logs/packer_output.txt
fi

packer build packer/prism.json 2>&1 | tee logs/packer_output.txt
tail -2 logs/packer_output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > current_ami.txt

HOME_IP=$(curl curl https://checkip.amazonaws.com/)
PRISM_AMI_ID=$(cat current_ami.txt)
echo "Build Complete! Edit terraform/variables.tf and customize for your info:"
echo "------------------------------------------------------------------------"
echo "Home IP: $HOME_IP"
echo "AMI ID: $PRISM_AMI_ID"