
module "lhg-nux-batch" {
  source = "../../../modules/linux-server"
  rg = "${data.azurerm_resource_group.white_label_rg.name}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"

  subnet_id = "${data.azurerm_subnet.wl_batch_prd_subnet.id}"

  boot_diag_storage_uri = "${data.azurerm_storage_account.lhg_core_storage_account.primary_blob_endpoint}"
  nb_instances = "1"
  vm_hostname_prefix = "lhg-nux-batch"
  vm_hostname_suffix = "p"
  tags = "${var.tags}"
  nsg_id = "${data.azurerm_subnet.wl_batch_prd_subnet.network_security_group_id}"
}

#
# WARNING !!! this is a temporary windows 2016 server machine holding batches not yet refactored to run on a linux batch vm
# PLEASE GET RID OF IT ASAP :)
#
module "lhg-win-batch" {
  source = "../../../modules/win-server-2016"
  nb_instances = "1"
  rg = "${data.azurerm_resource_group.white_label_rg.name}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"
  vm_hostname_suffix = "p"
  boot_diag_storage_uri = "${data.azurerm_storage_account.lhg_core_storage_account.primary_blob_endpoint}"
  vm_hostname_prefix = "lhg-win-batch"
  subnet_id = "${data.azurerm_subnet.wl_batch_prd_subnet.id}"
  public_ip_address_id = "${data.azurerm_public_ip.public_ip.id}"
  nsg_id = "${data.azurerm_subnet.wl_batch_prd_subnet.network_security_group_id}"

}

output "win_admin_username" {
  value = "${module.lhg-win-batch.vm_admin_user}"
}
output "win_admin_username_password" {
  value = "${module.lhg-win-batch.vm_admin_user_password}"
}

