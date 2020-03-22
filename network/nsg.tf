# ---------------------------------------------------------------------------------------------------------------
# NSGs
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_group" "api_prd_nsg" {
  name = "wl_api_prd_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}

resource "azurerm_network_security_group" "frontend_prd_nsg" {
  name = "wl_frontend_prd_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}

resource "azurerm_network_security_group" "cms_prd_nsg" {
  name = "wl_cms_prd_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}

resource "azurerm_network_security_group" "es_prd_nsg" {
  name = "wl_es_prd_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}

resource "azurerm_network_security_group" "bastion_prd_nsg" {
  name = "bastion_prd_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}
resource "azurerm_network_security_group" "lb_prd_nsg" {
  name = "lb_prd_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}
resource "azurerm_network_security_group" "batch_prd_nsg" {
  name = "batch_prd_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}
resource "azurerm_network_security_group" "puppet_server_nsg" {
  name = "puppet_server_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}
resource "azurerm_network_security_group" "mysql_server_nsg" {
  name = "mysql_server_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}
resource "azurerm_network_security_group" "internet_proxy_nsg" {
  name = "internet_proxy_nsg"
  location = "${var.location}"
  resource_group_name = "${var.rg_name}"
  tags = "${var.tags}"
}
# ---------------------------------------------------------------------------------------------------------------



# ---------------------------------------------------------------------------------------------------------------
# association of NGSs with subnets
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_api" {
  network_security_group_id = "${azurerm_network_security_group.api_prd_nsg.id}"
  subnet_id = "${azurerm_subnet.api_prd_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_es" {
  network_security_group_id = "${azurerm_network_security_group.es_prd_nsg.id}"
  subnet_id = "${azurerm_subnet.es_prd_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_front" {
  network_security_group_id = "${azurerm_network_security_group.frontend_prd_nsg.id}"
  subnet_id = "${azurerm_subnet.frontend_prd_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_cms" {
  network_security_group_id = "${azurerm_network_security_group.cms_prd_nsg.id}"
  subnet_id = "${azurerm_subnet.cms_prd_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_bastion" {
  network_security_group_id = "${azurerm_network_security_group.bastion_prd_nsg.id}"
  subnet_id = "${azurerm_subnet.bastion_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_lb" {
  network_security_group_id = "${azurerm_network_security_group.lb_prd_nsg.id}"
  subnet_id = "${azurerm_subnet.lb_prd_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_batch" {
  network_security_group_id = "${azurerm_network_security_group.batch_prd_nsg.id}"
  subnet_id = "${azurerm_subnet.batch_prd_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_puppet_server" {
  network_security_group_id = "${azurerm_network_security_group.puppet_server_nsg.id}"
  subnet_id = "${azurerm_subnet.puppet_server_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_mysql" {
  network_security_group_id = "${azurerm_network_security_group.mysql_server_nsg.id}"
  subnet_id = "${azurerm_subnet.mysql_server_subnet.id}"
}
resource "azurerm_subnet_network_security_group_association" "subnet_nsg_assoc_internet_proxy" {
  network_security_group_id = "${azurerm_network_security_group.internet_proxy_nsg.id}"
  subnet_id = "${azurerm_subnet.internet_proxy_subnet.id}"
}
# ---------------------------------------------------------------------------------------------------------------





