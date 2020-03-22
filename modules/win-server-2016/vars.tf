variable "rg" {}
variable "location" {}
variable "subnet_id" {}
variable "vm_size" {
  type = "string"
  default = "Standard_DS3_v2"
}
variable "nb_instances" {}
variable "vm_hostname_prefix" {}
variable "vm_hostname_suffix" {}
variable "os_image" {
  type = "list"
  default = [{
    publisher = "MicrosoftWindowsServer"
    offer = "WindowsServer"
    sku = "2016-Datacenter"
    version = "latest"
  }]
}
variable "vm_admin_username" {
  default = "azureadmin"
}
variable "tags" {
  type = "map"
  default = {
    env = "win2016DC"
  }
}
variable "boot_diag_storage_uri" {}
variable "public_ip_address_id" {
  default = ""
}
variable "nsg_id" {}