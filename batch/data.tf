data "azurerm_resource_group" "white_label_rg" {
  name = "white_label_rg"
}

data "azurerm_storage_account" "lhg_core_storage_account" {
  name = "lhgmbstorageaccount"
  resource_group_name = "bastion_core"
}


# Subnets IDs
data "azurerm_subnet" "wl_batch_prd_subnet" {
  name = "wl_batch_prd_subnet"
  resource_group_name = "white_label_rg"
  virtual_network_name = "white_label_vpc"
}

data "azurerm_container_registry" "acr" {
  name = "wlprd"
  resource_group_name = "white_label_rg"
}

data "azurerm_public_ip" "public_ip" {
  name = "win2016_batch_public_ip"
  resource_group_name = "white_label_rg"
}

