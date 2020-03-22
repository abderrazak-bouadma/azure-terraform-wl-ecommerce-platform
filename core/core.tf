resource "azurerm_resource_group" "white_label_rg" {
  location = "West Europe"
  name = "white_label_rg"
  tags = "${var.tags}"
}

resource "azurerm_key_vault" "wl_p_vault" {
  name = "wl-p-vault"
  location = "${azurerm_resource_group.white_label_rg.location}"
  resource_group_name = "${azurerm_resource_group.white_label_rg.name}"
  "sku" {
    name = "standard"
  }
  tenant_id = "${var.tenant_id}"

  access_policy {
    object_id = "${var.object_id}"
    tenant_id = "${var.tenant_id}"

    key_permissions =[
      "list",
      "get",
      "create"
    ]

    secret_permissions = [
      "list",
      "get",
      "set",
      "delete"
    ]

  }
  tags = "${var.tags}"
}


resource "azurerm_key_vault_secret" "store_vsts_pat" {
  name = "vsts-agent-pat"
  value = "${file(".pat")}"
  vault_uri = "${azurerm_key_vault.wl_p_vault.vault_uri}"
}

output "azurerm_key_vault_name" {
  value = "${azurerm_key_vault.wl_p_vault.name}"
}

output "azurerm_key_vault_uri" {
  value = "${azurerm_key_vault.wl_p_vault.vault_uri}"
}