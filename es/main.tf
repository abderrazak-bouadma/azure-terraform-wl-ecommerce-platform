
module "lhg-nux-es" {
  source = "../../../modules/linux-server"
  rg = "${data.azurerm_resource_group.white_label_rg.name}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"

  subnet_id = "${data.azurerm_subnet.wl_es_prd_subnet.id}"

  boot_diag_storage_uri = "${data.azurerm_storage_account.lhg_core_storage_account.primary_blob_endpoint}"
  nb_instances = "3"
  vm_hostname_prefix = "lhg-nux-es"
  vm_hostname_suffix = "p"
  tags = "${var.tags}"
  nsg_id = "${data.azurerm_subnet.wl_es_prd_subnet.network_security_group_id}"
}

resource "null_resource" "install_es" {

  count = "${module.lhg-nux-es.nb_instances}"

  connection {
    type = "ssh"
    user = "${module.lhg-nux-es.vm_admin_user}"
    host = "${element(module.lhg-nux-es.host, count.index)}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -",
      "sudo apt-get -y install apt-transport-https",
      "echo \"deb https://artifacts.elastic.co/packages/7.x/apt stable main\" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list",
      "sudo apt-get update",
      "sudo apt-get install elasticsearch",
      "sudo /bin/systemctl daemon-reload",
      "sudo /bin/systemctl enable elasticsearch.service",
      "sudo systemctl start elasticsearch.service"
    ]
  }


}

