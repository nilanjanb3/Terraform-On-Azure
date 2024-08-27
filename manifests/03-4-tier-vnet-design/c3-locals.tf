# locals.tf
# This file defines local variables that are used in the Terraform configuration.
#
# The local variables are defined using the `locals` block.
#
# The `owners` variable is set to the value of the `business_divsion` input variable.
# The `environment` variable is set to the value of the `environment` input variable.
# The `resource_name_prefix` variable is set to a string that is constructed by concatenating the `owners` and `environment` variables with a hyphen.
# The `common_tags` variable is a map that contains the `owner` and `environment` variables as keys, and the values are set to the corresponding local variables.

locals {
  # The business division the infrastructure belongs to
  owners = var.business_divsion

  # The environment the infrastructure is in
  environment = var.environment

  # The resource name prefix is constructed by concatenating the business division and environment
  resource_name_prefix = "${local.owners}-${local.environment}"

  # Common tags that are applied to all resources
  common_tags = {
    # The owner of the infrastructure
    owner = local.owners

    # The environment the infrastructure is in
    environment = local.environment
  }
}

