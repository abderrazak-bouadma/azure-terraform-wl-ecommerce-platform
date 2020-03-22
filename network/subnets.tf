resource "azurerm_subnet" "bastion_subnet" {
  name = "wl_bastion_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.10.0/28"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}
resource "azurerm_subnet" "api_prd_subnet" {
  name = "wl_api_prd_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.11.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}
resource "azurerm_subnet" "frontend_prd_subnet" {
  name = "wl_frontend_prd_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.12.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}
resource "azurerm_subnet" "cms_prd_subnet" {
  name = "wl_cms_prd_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.13.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}
resource "azurerm_subnet" "es_prd_subnet" {
  name = "wl_es_prd_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.14.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}
resource "azurerm_subnet" "lb_prd_subnet" {
  name = "wl_lb_prd_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.15.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}
resource "azurerm_subnet" "batch_prd_subnet" {
  name = "wl_batch_prd_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.16.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}

resource "azurerm_subnet" "mysql_server_subnet" {
  name = "mysql_server_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.17.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
  service_endpoints    = ["Microsoft.Sql"]
}


resource "azurerm_subnet" "puppet_server_subnet" {
  name = "puppet_server_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.20.0/26"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}

resource "azurerm_subnet" "internet_proxy_subnet" {
  name = "internet_proxy_subnet"
  resource_group_name = "${var.rg_name}"
  address_prefix = "10.20.30.0/29"
  virtual_network_name = "${azurerm_virtual_network.lhg_white_label_vpc.name}"
}


