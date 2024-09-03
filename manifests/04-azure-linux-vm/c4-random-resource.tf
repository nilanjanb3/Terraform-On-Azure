# This resource block creates a random string resource which will be used to create a unique name for the Azure resources.
# The special, numeric and upper attributes are set to false to ensure that the generated string does not contain any special characters, numbers or uppercase letters.
# The length attribute is set to 6 to generate a 6 character long string.
resource "random_string" "myrandom" {
  special = false
  numeric = false
  upper   = false
  length  = 6
}

