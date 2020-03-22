variable "location" {
  default = "West Europe"
}
variable "rg_name" {
  default = "white_label_rg"
}
variable "tags" {
  type = "map"
  default = {
    env = "wl-prd"
    lifecycle = "WIP"
    generator = "terraform"
    costcenter= "DF"
    scope = "wl"
  }
}