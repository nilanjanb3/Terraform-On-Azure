# variable "rg-locations" {
#   type = map(string)
#   default = {
#     "rg1" = "westindia"
#     "rg2" = "southindia"
#   }

# }

# This variable block defines a variable named "rg-locations-2"

# The type of the variable is a map where the keys are strings and the values are objects
# In other words, this variable can accept a map where each key is a string and each value is an object
variable "rg-locations-2" {

  # The type of the variable is set to "map" which means it can accept a map as its value
  type = map(object({

    # The object has three properties

    # The property "name" is a string
    # This property is required and must be a string
    name = string

    # The property "location" is a string
    # This property is required and must be a string
    location = string

    # The property "tags" is a map where the keys are strings and the values are strings
    # This property is required and must be a map where each key is a string and each value is a string
    tags = map(string)

  }))


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

}

