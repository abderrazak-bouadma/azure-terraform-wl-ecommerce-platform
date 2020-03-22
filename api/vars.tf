variable "tags" {
  type = "map"
  default = {
    env = "wl-prd"
    lifecycle = "WIP"
    generator = "terraform"
    costcenter= "DF"
    scope = "lh_api"

  }
}

