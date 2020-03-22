# ---------------------------------------------------------------------------------------------------------------
# Allowing BASTION to've access through port 22 on all subnets
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "bastion_allow_ssh_22" {
  name = "bastion-allow-ssh-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 100
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.bastion_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "bastion_outbound_proxy_3128" {
  name = "bastion_outbound_proxy_3128"
  access = "Allow"
  direction = "Outbound"
  protocol = "Tcp"
  priority = 101
  source_port_range           = "*"
  destination_port_range      = "3128"
  source_address_prefix       = "*"
  destination_address_prefix  = "10.20.30.4"
  network_security_group_name = "${azurerm_network_security_group.bastion_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------






# ---------------------------------------------------------------------------------------------------------------
# API Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "bastion_api_subnet_22" {
  name = "bastion-api-subnet-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 200
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.api_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_api_tcp_80_from_lb" {
  name = "allow-api-subnet-80-from-lb"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 201
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.lb_prd_subnet.address_prefix}"
  network_security_group_name = "${azurerm_network_security_group.api_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_api_tcp_80_from_batch" {
  name = "allow-api-subnet-80-from-batch"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 202
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "${azurerm_subnet.batch_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.api_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_api_tcp_443_from_lb" {
  name = "allow-api-subnet-443-from-lb"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 203
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.lb_prd_subnet.address_prefix}"
  network_security_group_name = "${azurerm_network_security_group.api_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_api_tcp_443_from_batch" {
  name = "allow-api-subnet-443-from-batch"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 204
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.batch_prd_subnet.address_prefix}"
  network_security_group_name = "${azurerm_network_security_group.api_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------








# ---------------------------------------------------------------------------------------------------------------
# Elastic search Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_es_subnet_22" {
  name = "allow-es-subnet-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 300
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.es_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_es_subnet_9200_9300_from_api" {
  name = "allow-es-subnet-9200-9300-from-api"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 301
  source_port_range           = "*"
  destination_port_range      = "9200-9300"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.api_prd_subnet.address_prefix}"
  network_security_group_name = "${azurerm_network_security_group.es_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_es_subnet_9200_9300_from_batch" {
  name = "allow-es-subnet-9200-9300-from-batch"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 302
  source_port_range           = "*"
  destination_port_range      = "9200-9300"
  source_address_prefix       = "*"
  destination_address_prefix  = "${azurerm_subnet.batch_prd_subnet.address_prefix}"
  network_security_group_name = "${azurerm_network_security_group.es_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------








# ---------------------------------------------------------------------------------------------------------------
# frontend Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_frontend_subnet_22" {
  name = "allow-frontend-subnet-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 400
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.frontend_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_frontend_subnet_80" {
  name = "allow-frontend-subnet-80"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 401
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.frontend_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_frontend_subnet_443" {
  name = "allow-frontend-subnet-443"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 402
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.frontend_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------






# ---------------------------------------------------------------------------------------------------------------
# CMS Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_cms_subnet_22" {
  name = "allow-cms-subnet-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 500
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.cms_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_cms_subnet_80_from_api" {
  name = "allow-cms-subnet-80-from-api"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 501
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "${azurerm_subnet.api_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.cms_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_cms_subnet_443_from_api" {
  name = "allow-cms-subnet-443-from-api"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 502
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "${azurerm_subnet.api_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.cms_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_access_80_from_batch" {
  name = "allow-access-80-from-batch"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 503
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "${azurerm_subnet.batch_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.cms_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_cms_subnet_443_from_batch" {
  name = "allow-cms-subnet-443-from-batch"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 504
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "${azurerm_subnet.batch_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.cms_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_access_80_from_lb" {
  name = "allow-access-80-from-lb"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 505
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "${azurerm_subnet.lb_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.cms_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_cms_subnet_443_from_lb" {
  name = "allow-cms-subnet-443-from-lb"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 506
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "${azurerm_subnet.lb_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.cms_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------





# ---------------------------------------------------------------------------------------------------------------
# LB Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_lb_subnet_22" {
  name = "allow-lb-subnet-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 600
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.lb_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_lb_subnet_80" {
  name = "allow-lb-subnet-80"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 601
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.lb_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_lb_subnet_443" {
  name = "allow-lb-subnet-443"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 602
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.lb_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------





# ---------------------------------------------------------------------------------------------------------------
# Batch Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_batch_subnet_22" {
  name = "allow-batch-subnet-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 700
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.batch_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_batch_subnet_rdp" {
  name = "allow-batch-subnet-rdp"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 701
  source_port_range           = "*"
  destination_port_range      = "3389"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.batch_prd_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------




# ---------------------------------------------------------------------------------------------------------------
# Puppet Server Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_pupperserver_subnet_22" {
  name = "allow-puppetserver-subnet-22"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 800
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.puppet_server_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_pupperserver_subnet_80" {
  name = "allow-puppetserver-subnet-80"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 801
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.puppet_server_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_pupperserver_subnet_443" {
  name = "allow-puppetserver-subnet-443"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 802
  source_port_range           = "*"
  destination_port_range      = "443"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.puppet_server_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_pupperserver_subnet_8140" {
  name = "allow-puppetserver-subnet-8140"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 803
  source_port_range           = "*"
  destination_port_range      = "8140"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.puppet_server_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------
# Mysql Server Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_mysql_subnet_3306_from_cms" {
  name = "allow-mysql-subnet-3306_from_cms"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 900
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "${azurerm_subnet.cms_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.mysql_server_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_mysql_subnet_3306_from_batch" {
  name = "allow-mysql-subnet-3306_from_cms"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 901
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "${azurerm_subnet.batch_prd_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.mysql_server_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------


# ---------------------------------------------------------------------------------------------------------------
# Internet Proxy Cluster
# ---------------------------------------------------------------------------------------------------------------
resource "azurerm_network_security_rule" "allow_internet_proxy_subnet_22" {
  name = "allow-mysql-subnet-3306_from_cms"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 1000
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "${azurerm_subnet.bastion_subnet.address_prefix}"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.internet_proxy_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
resource "azurerm_network_security_rule" "allow_internet_proxy_subnet_all" {
  name = "allow-mysql-subnet-3306_from_cms"
  access = "Allow"
  direction = "Inbound"
  protocol = "Tcp"
  priority = 1001
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  network_security_group_name = "${azurerm_network_security_group.internet_proxy_nsg.name}"
  resource_group_name = "${var.rg_name}"
}
# ---------------------------------------------------------------------------------------------------------------