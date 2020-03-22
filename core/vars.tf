variable "tags" {
  type = "map"
  default = {
    env = "wl-prd"
    lifecycle = "WIP"
    generator = "terraform"
    costcenter= "DF"
    scope = "core"
  }
}
variable "object_id" {}
variable "tenant_id" {}