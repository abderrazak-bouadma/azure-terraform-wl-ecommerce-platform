data "azurerm_virtual_machine" "lhg-nux-cms-0p" {
  name = "lhg-nux-cms-0p"
  resource_group_name = "${data.azurerm_resource_group.white_label_rg.name}"
}

resource "azurerm_managed_disk" "lhg-nux-cms-p-data-disk" {
  count = "${module.lhg-nux-cms.nb_instances}"
  name = "${element(module.lhg-nux-cms.vm_name, count.index)}-data-disk"
  location = "${data.azurerm_resource_group.white_label_rg.location}"
  resource_group_name = "${data.azurerm_resource_group.white_label_rg.name}"
  create_option = "Empty"
  storage_account_type = "Standard_LRS"
  disk_size_gb = 20
  tags = "${var.tags}"
}

resource "azurerm_virtual_machine_data_disk_attachment" "attach-data-disk-to-cms" {
  count = "${module.lhg-nux-cms.nb_instances}"

  caching = "None"
  lun = 10
  managed_disk_id = "${element(azurerm_managed_disk.lhg-nux-cms-p-data-disk.*.id,count.index)}"
  virtual_machine_id = "${element(module.lhg-nux-cms.vm_id, count.index)}"
}
