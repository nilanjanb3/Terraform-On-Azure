

# 01-Remote-State-Storage-Account README

This directory contains Terraform configuration files for creating a storage account in Azure to store Terraform remote state.

## Overview

Terraform remote state allows you to store the state of your infrastructure in a centralized location, making it easier to manage and collaborate on infrastructure as code. This configuration creates a storage account in Azure to store Terraform remote state.

## Directory Structure

* `terraform.tf`: This file configures the Terraform version and provider versions.
* `main.tf`: This file defines the main Terraform configuration for creating the storage account.
* `variables.tf`: This file defines input variables for the Terraform configuration.

## Configuration Files

### `terraform.tf`

This file configures the Terraform version and provider versions. It specifies the following:

* `required_version`: The minimum Terraform version required to run this configuration.
* `required_providers`: The AzureRM provider version required to run this configuration.

### `main.tf`

This file defines the main Terraform configuration for creating the storage account. It creates the following resources:

* `azurerm_resource_group`: A resource group to contain the storage account.
* `azurerm_storage_account`: The storage account to store Terraform remote state.

The storage account is configured with the following settings:

* `name`: The name of the storage account.
* `resource_group_name`: The name of the resource group containing the storage account.
* `location`: The location of the storage account.
* `account_tier`: The tier of the storage account (Standard or Premium).
* `account_replication_type`: The replication type of the storage account (LRS, GRS, or RAGRS).
* `tags`: Tags to apply to the storage account.

### `variables.tf`

This file defines input variables for the Terraform configuration. It defines the following variables:

* `storage_account_name`: The name of the storage account.
* `resource_group_name`: The name of the resource group containing the storage account.
* `location`: The location of the storage account.
* `account_tier`: The tier of the storage account (Standard or Premium).
* `account_replication_type`: The replication type of the storage account (LRS, GRS, or RAGRS).

## Usage

1. Initialize the Terraform configuration by running `terraform init` in the root directory.
2. Review and modify the configuration files as needed.
3. Apply the configuration by running `terraform apply` in the root directory.

Note: Make sure to update the `terraform.tf` file to reflect the correct Terraform version and provider versions for your environment.

## Example Output

The following is an example output of the Terraform configuration:
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

storage_account_name = "nilanjanremotetfstate"
resource_group_name = "terraform-rg"
location = "Central India"
account_tier = "Standard"
account_replication_type = "LRS"
```
This output shows the name of the storage account, resource group, location, account tier, and replication type.