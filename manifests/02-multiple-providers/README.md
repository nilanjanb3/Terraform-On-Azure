# 02-Multiple-Providers README

This directory contains Terraform configuration files for creating multiple Azure resource groups in different regions using different Azure providers.

## Overview

In this configuration, multiple resource groups are created in different Azure regions using distinct provider configurations. This setup allows you to manage resources in various regions with specific provider settings.

## Directory Structure

* `terraform.tf`: This file configures the Terraform version and provider versions.
* `main.tf`: This file defines the main Terraform configuration for creating resource groups.
* `variables.tf`: This file defines input variables for the Terraform configuration.

## Configuration Files

### `terraform.tf`

This file configures the Terraform version and provider versions. It specifies the following:

* `required_version`: The minimum Terraform version required to run this configuration.
* `required_providers`: The AzureRM provider version required to run this configuration.

### `main.tf`

This file defines the main Terraform configuration for creating multiple resource groups in different regions. It creates the following resources:

* `azurerm_resource_group`: Multiple resource groups in different Azure regions.

Each resource group is configured with the following settings:

* `name`: The name of the resource group.
* `location`: The location of the resource group.
* `provider`: The provider configuration to use for creating the resource group.

### `variables.tf`

This file defines input variables for the Terraform configuration. It defines the following variables:

* `resource_group_names`: The names of the resource groups to create.
* `locations`: The locations of the resource groups.
* `provider_aliases`: The aliases of the provider configurations to use for each resource group.

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

resource_group_names = ["demorg1", "demorg2"]
locations = ["South India", "West India"]
provider_aliases = ["default", "provider2-south-india"]
```
This output shows the names of the resource groups, locations, and provider aliases created by the Terraform configuration.