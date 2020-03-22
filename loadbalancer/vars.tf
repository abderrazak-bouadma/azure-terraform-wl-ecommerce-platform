variable "tags" {
  type = "map"
  default = {
    env = "wl-prd"
    lifecycle = "WIP"
    generator = "terraform"
    costcenter= "DF"
    scope = "iLBs"
  }
}
variable vm_size {
  type = "string"
  default = "Standard_DS2_v2"
}

variable "os_image_ref" {
  type = "list"
  default = [{
      publisher = "credativ"
      offer = "Debian"
      sku = "9"
      version = "latest"
    }]
}