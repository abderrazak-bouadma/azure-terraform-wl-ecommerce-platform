
module "lhg-nux-frontend" {
  source = "../../../modules/linux-server"
  rg = "${data.azurerm_resource_group.white_label_rg.name}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"

  subnet_id = "${data.azurerm_subnet.wl_frontend_prd_subnet.id}"

  boot_diag_storage_uri = "${data.azurerm_storage_account.lhg_core_storage_account.primary_blob_endpoint}"
  nb_instances = "4"
  vm_hostname_prefix = "lhg-nux-frontend"
  vm_hostname_suffix = "p"
  tags = "${var.tags}"
  nsg_id = "${data.azurerm_subnet.wl_frontend_prd_subnet.network_security_group_id}"
}


resource "null_resource" "install_node" {

  count = "${module.lhg-nux-frontend.nb_instances}"

  connection {
    type = "ssh"
    user = "${module.lhg-nux-frontend.vm_admin_user}"
    host = "${element(module.lhg-nux-frontend.host, count.index)}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install ufw",
      "sudo apt-get -y install nginx",
      "sudo ufw status"
    ]
  }

}