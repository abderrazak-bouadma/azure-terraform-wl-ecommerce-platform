module "lhg-nux-proxy" {
  source = "../../../modules/linux-server"
  rg = "${data.azurerm_resource_group.white_label_rg.name}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"

  subnet_id = "${data.azurerm_subnet.wl_internet_proxy_prd_subnet.id}"

  boot_diag_storage_uri = "${data.azurerm_storage_account.lhg_core_storage_account.primary_blob_endpoint}"
  nb_instances = "1"
  vm_hostname_prefix = "lhg-nux-proxy"
  vm_hostname_suffix = "p"
  tags = "${var.tags}"
  nsg_id = "${data.azurerm_subnet.wl_internet_proxy_prd_subnet.network_security_group_id}"
  public_ip_address_id = "${data.azurerm_public_ip.public_ip.id}"
}

