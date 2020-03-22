resource "random_string" "acr_pwd" {
  length = 32
  special = true
  number = true
}

resource "azurerm_container_registry" "acr" {
  location = "${azurerm_resource_group.white_label_rg.location}"
  name = "wlprd"
  resource_group_name = "${azurerm_resource_group.white_label_rg.name}"
  sku = "Standard"
  admin_enabled = true
  tags = "${var.tags}"
}

output "acr_name" {
  value = "${azurerm_container_registry.acr.name}"
}

output "acr_admin" {
  value = "${azurerm_container_registry.acr.admin_username}"
}

output "acr_pwd" {
  value = "${azurerm_container_registry.acr.admin_password}"
}

