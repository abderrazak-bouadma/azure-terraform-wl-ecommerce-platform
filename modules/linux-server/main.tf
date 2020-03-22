data "azurerm_key_vault" "wl_p_vault" {
  name = "wl-p-vault"
  resource_group_name = "${var.rg}"
}

data "azurerm_key_vault_secret" "bastion_ssh_public_key" {
  name = "bastion-ssh-public-key"
  vault_uri = "${data.azurerm_key_vault.wl_p_vault.vault_uri}"
}


resource "azurerm_virtual_machine" "linux_server" {
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
    computer_name = "${var.vm_hostname_prefix}-${count.index}${var.vm_hostname_suffix}"
    admin_username = "${var.vm_admin_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/${var.vm_admin_username}/.ssh/authorized_keys"
      key_data = "${data.azurerm_key_vault_secret.bastion_ssh_public_key.value}"
    }

  }


  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "${var.vm_admin_username}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "echo \"This command avoids closing session after command line error\" >> /home/${var.vm_admin_username}/.bashrc",
      "echo \"set +o errexit\" >> /home/${var.vm_admin_username}/.bashrc"
    ]
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "${var.vm_admin_username}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y puppet",
      "sudo apt-get install -y curl"
    ]
  }

  provisioner "file" {
    connection {
      type = "ssh"
      user = "${var.vm_admin_username}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    source = "puppet.conf"
    destination = "/home/${var.vm_admin_username}/puppet.conf"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "${var.vm_admin_username}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
      "sudo mv /home/${var.vm_admin_username}/puppet.conf /etc/puppet/puppet.conf",
      "sudo sed -i \"s/FQDN/$(hostname -f)/g\" /etc/puppet/puppet.conf"
    ]
  }

  tags = "${var.tags}"
}

output "vm_admin_user" {
  value = "${var.vm_admin_username}"
}

output "nb_instances" {
  value = "${var.nb_instances}"
}

output "host" {
  value = "${azurerm_network_interface.nic.*.private_ip_address}"
}

output "vm_id" {
  value = "${azurerm_virtual_machine.linux_server.*.id}"
}

output "vm_name" {
  value = "${azurerm_virtual_machine.linux_server.*.name}"
}


