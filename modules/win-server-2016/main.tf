resource "random_string" "vm_admin_password" {
  length = 14
  special = true
}

resource "azurerm_virtual_machine" "win2016dc_server" {
  count = "${var.nb_instances}"
  name = "${var.vm_hostname_prefix}-${count.index}${var.vm_hostname_suffix}"
  resource_group_name = "${var.rg}"
  location = "${var.location}"
  network_interface_ids = [
    "${element(azurerm_network_interface.nic.*.id, count.index)}"]

  storage_image_reference ="${var.os_image}"

  boot_diagnostics {
    enabled = true
    storage_uri = "${var.boot_diag_storage_uri}"
  }

  "storage_os_disk" {
    create_option = "FromImage"
    caching = "ReadWrite"
    managed_disk_type = "Standard_LRS"
    name = "osdisk-${var.vm_hostname_prefix}-${count.index}${var.vm_hostname_suffix}"
  }

  delete_os_disk_on_termination = true

  vm_size = "${var.vm_size}"

  os_profile {
    computer_name = "lhgbatchwindows"
    admin_username = "${var.vm_admin_username}"
    admin_password = "${random_string.vm_admin_password.result}"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = false
    provision_vm_agent = false
  }

  tags = "${var.tags}"
}

output "vm_admin_user" {
  value = "${var.vm_admin_username}"
}
output "vm_admin_user_password" {
  value = "${random_string.vm_admin_password.result}"
}

output "nb_instances" {
  value = "${var.nb_instances}"
}

output "host" {
  value = "${azurerm_network_interface.nic.*.private_ip_address}"
}

output "vm_id" {
  value = "${azurerm_virtual_machine.win2016dc_server.*.id}"
}

output "vm_name" {
  value = "${azurerm_virtual_machine.win2016dc_server.*.name}"
}


