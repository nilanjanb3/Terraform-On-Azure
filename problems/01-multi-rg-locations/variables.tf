# variable "rg-locations" {
#   type = map(string)
#   default = {
#     "rg1" = "westindia"
#     "rg2" = "southindia"
#   }

# }

variable "rg-locations-2" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)
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
