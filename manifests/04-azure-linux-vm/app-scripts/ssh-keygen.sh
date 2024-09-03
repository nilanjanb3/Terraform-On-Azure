#! /bin/bash
cd ..
mkdir ssh-keys
ssh-keygen \
 -m PEM \
 -t rsa \
 -b 4069 \
 -C "azureuser@myserver" \
 -f $(pwd)/ssh-keys/terraform-azure.pem

mv ./ssh-keys/terraform-azure.pem.pub ./ssh-keys/terraform-azure.pub