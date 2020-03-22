# -------------------------------------------------------------------------
# main white label VPC
# -------------------------------------------------------------------------

resource "azurerm_virtual_network" "lhg_white_label_vpc" {
  address_space = ["10.20.0.0/16"]
  name = "white_label_vpc"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"

  tags = "${var.tags}"

}

output "wl_vpc_name" {
  value = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}

output "wl_vpc_id" {
  value = "${azurerm_virtual_network.lhg_white_label_vpc.id}"
}

output "wl_vpc_adr_space" {
  value = "${azurerm_virtual_network.lhg_white_label_vpc.address_space}"
}


