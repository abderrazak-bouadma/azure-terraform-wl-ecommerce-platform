variable "rg" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_size" {
  type = "string"
  default = "Standard_DS2_v2"
}
variable "vm_admin_username" {
  default = "azureadmin"
}
variable "boot_diag_storage_uri" {}
variable "tags" {
  type = "map"
  default = {
    env = "debian"
  }
}
variable "nb_instances" {}
variable "vm_hostname_prefix" {}
variable "vm_hostname_suffix" {}
variable "os_image" {
  type = "list"
  default = [{
    publisher = "credativ"
    offer = "Debian"
    sku = "9"
    version = "latest"
  }]
}
variable "public_ip_address_id" {
  default = ""
}
variable "nsg_id" {}