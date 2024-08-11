

# 01-Multi-RG-Locations README

This directory contains Terraform configuration files for creating multiple Azure resource groups in different regions using a single Azure provider.

## Overview

In this configuration, multiple resource groups are created in different Azure regions using a single provider configuration. This setup allows you to manage resources in various regions with a single provider settings.

## Directory Structure

* `variables.tf`: This file defines input variables for the Terraform configuration.
* `main.tf`: This file defines the main Terraform configuration for creating resource groups.

## Configuration Files

### `variables.tf`

This file defines input variables for the Terraform configuration. It defines a single variable `rg-locations-2` which is a map of objects. Each object represents a resource group and has three properties:

* `name`: The name of the resource group.
* `location`: The location of the resource group.
* `tags`: A map of tags for the resource group.

```terraform
variable "rg-locations-2" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
  }))
}
```

The default value for this variable is defined as:

```terraform
default = {
  rg1 = {
    name     = "rg1"
    location = "westindia"
    tags = {
      "env"  = "dev"
      "team" = "devops"
    }
  },
  rg2 = {
    name     = "rg2"
    location = "centralindia"
    tags = {
      "env"  = "dev"
      "team" = "devops"
    }
  }
}
```

### `main.tf`

This file defines the main Terraform configuration for creating resource groups. It uses the `azurerm_resource_group` resource to create multiple resource groups in different regions.

```terraform
resource "azurerm_resource_group" "rgs" {
  for_each = var.rg-locations-2

  name     = each.key
  location = each.value.location
  tags     = each.value.tags
}
```

The `for_each` meta-argument is used to iterate over the elements of the `rg-locations-2` map. For each element, a new resource group is created with the specified name, location, and tags.

## Usage

1. Initialize the Terraform configuration by running `terraform init` in the root directory.
2. Review and modify the configuration files as needed.
3. Apply the configuration by running `terraform apply` in the root directory.

Note: Make sure to update the `variables.tf` file to reflect the correct values for your environment.

## Example Output

The following is an example output of the Terraform configuration:
```
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

resource_group_names = ["rg1", "rg2"]
locations = ["westindia", "centralindia"]
tags = {
  "env"  = "dev"
  "team" = "devops"
}
```
This output shows the names of the resource groups, locations, and tags created by the Terraform configuration.