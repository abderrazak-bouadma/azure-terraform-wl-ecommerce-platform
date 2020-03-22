data "azurerm_resource_group" "white_label_rg" {
  name = "white_label_rg"
}

data "azurerm_storage_account" "lhg_core_storage_account" {
  name = "lhgmbstorageaccount"
  resource_group_name = "bastion_core"
}


# Subnets IDs
data "azurerm_subnet" "wl_api_prd_subnet" {
  name = "wl_api_prd_subnet"
  resource_group_name = "white_label_rg"
  virtual_network_name = "white_label_vpc"
}






