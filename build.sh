#!/bin/bash
if [ -f "logs/packer_output.txt" ]; then
    rm logs/packer_output.txt
fi
#

if [[ ! -n "$AWS_ACCESS_KEY_ID" ]] || [[ ! -n $AWS_SECRET_ACCESS_KEY ]]; then
    echo "The AWS_ACCESS_KEY_ID and \$AWS_SECRET_ACCESS_KEY must exist."
    echo ""
    echo "To set these, just run the following and enter your keys:"
    echo "      export AWS_ACCESS_KEY_ID=12345689"
    echo "      export AWS_SECRET_ACCESS_KEY=12345689"
    exit 1
fi

packer build packer/prism.json 2>&1 | tee logs/packer_output.txt
tail -2 logs/packer_output.txt | head -2 | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }' > current_ami.txt

echo "Build Complete!"