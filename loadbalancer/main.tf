module "lhg-nux-lb" {
  source = "../../../modules/linux-server"
  rg = "${data.azurerm_resource_group.white_label_rg.name}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"

  subnet_id = "${data.azurerm_subnet.wl_lb_prd_subnet.id}"

  boot_diag_storage_uri = "${data.azurerm_storage_account.lhg_core_storage_account.primary_blob_endpoint}"
  nb_instances = "2"
  vm_hostname_suffix = "p"
  vm_hostname_prefix = "lhg-nux-lb"
  nsg_id = "${data.azurerm_subnet.wl_lb_prd_subnet.network_security_group_id}"
}


