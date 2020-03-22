data "azurerm_resource_group" "white_label_rg" {
  name = "white_label_rg"
}

data "azurerm_storage_account" "lhg_core_storage_account" {
  name = "lhgmbstorageaccount"
  resource_group_name = "bastion_core"
}


# Subnets IDs
data "azurerm_subnet" "wl_internet_proxy_prd_subnet" {
  name = "internet_proxy_subnet"
  resource_group_name = "white_label_rg"
  virtual_network_name = "white_label_vpc"
}

data "azurerm_public_ip" "public_ip" {
  name = "internet_proxy_public_ip"
  resource_group_name = "white_label_rg"
}

