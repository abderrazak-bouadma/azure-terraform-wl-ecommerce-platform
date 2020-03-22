resource "azurerm_public_ip" "bastion_public_ip" {
  name = "bastion_public_ip"
  location = "${var.location}"
  allocation_method = "Dynamic"
  resource_group_name = "${var.rg_name}"
  domain_name_label = "lhg-bastion"

  tags = "${var.tags}"
}

resource "azurerm_public_ip" "puppet_public_ip" {
  name = "puppet_public_ip"
  location = "${var.location}"
  allocation_method = "Dynamic"
  resource_group_name = "${var.rg_name}"
  domain_name_label = "lhg-puppet"

  tags = "${var.tags}"
}

resource "azurerm_public_ip" "internet_proxy_public_ip" {
  name = "internet_proxy_public_ip"
  location = "${var.location}"
  allocation_method = "Dynamic"
  resource_group_name = "${var.rg_name}"
  domain_name_label = "lhg-internet-proxy"

  tags = "${var.tags}"
}

resource "azurerm_public_ip" "win2016_batch_public_ip" {
  name = "win2016_batch_public_ip"
  location = "${var.location}"
  allocation_method = "Dynamic"
  resource_group_name = "${var.rg_name}"
  domain_name_label = "lhg-win-batch"

  tags = "${var.tags}"
}