data "azurerm_resource_group" "white_label_rg" {
  name = "white_label_rg"
}

data "azurerm_storage_account" "lhg_core_storage_account" {
  name = "lhgmbstorageaccount"
  resource_group_name = "bastion_core"
}


# Subnets IDs
data "azurerm_subnet" "wl_cms_prd_subnet" {
  name = "wl_cms_prd_subnet"
  resource_group_name = "white_label_rg"
  virtual_network_name = "white_label_vpc"
}

data "azurerm_subnet" "wl_mysql_prd_subnet" {
  name = "mysql_server_subnet"
  resource_group_name = "white_label_rg"
  virtual_network_name = "white_label_vpc"
}


