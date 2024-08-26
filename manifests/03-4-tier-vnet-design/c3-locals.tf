locals {
  owners               = var.business_divsion
  environment          = var.environment
  resource_name_prefix = "${local.owners}-${local.environment}"
  # resource_name_prefix = "${var.business_divsion}-${var.environment}"

  common_tags = {
    owner       = local.owners
    environment = local.environment
  }
}
