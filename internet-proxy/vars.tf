variable "tags" {
  type = "map"
  default = {
    env = "wl-prd"
    generator = "terraform"
    costcenter= "DF"
    scope = "batch"
    docker = "yes"
    custom = "internet proxy"
  }
}
