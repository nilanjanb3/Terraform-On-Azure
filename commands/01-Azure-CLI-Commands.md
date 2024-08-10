###  Azure Regions
```sh
# Get Azure Regions
az account list-locations -o table
```

### Azure CLI Configurations
```sh
# Login Using Azure Account
az login

# Get Subscriptions
az account list

# Set Subscription with CLI
az account set --subscription=<subscription id>
```

### Terraform Commands
```sh
terraform init

terraform validate

terraform plan

terraform apply

terraform apply --auto-approve
```

