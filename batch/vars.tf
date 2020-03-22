variable "tags" {
  type = "map"
  default = {
    env = "wl-prd"
    generator = "terraform"
    costcenter= "DF"
    scope = "batch"
    docker = "yes"
    server = "linux"
  }
}

variable "tags-win" {
  type = "map"
  default = {
    env = "wl-prd"
    generator = "terraform"
    costcenter= "DF"
    scope = "batch"
    server = "win2016DC"
  }
}
