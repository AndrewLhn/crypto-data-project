#!/bin/bash
cd ~/crypto-data-project/terraform

echo "WARNING: This will destroy all infrastructure!"
read -p "Are you sure? (y/n) " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    terraform destroy
fi
