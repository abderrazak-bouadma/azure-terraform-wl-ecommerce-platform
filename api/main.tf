module "lhg-nux-api" {
  source = "../../../modules/linux-server"
  rg = "${data.azurerm_resource_group.white_label_rg.name}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"

  subnet_id = "${data.azurerm_subnet.wl_api_prd_subnet.id}"

  boot_diag_storage_uri = "${data.azurerm_storage_account.lhg_core_storage_account.primary_blob_endpoint}"

  nb_instances = "4"
  vm_hostname_prefix = "lhg-nux-api"
  vm_hostname_suffix = "p"
  tags = "${var.tags}"
  nsg_id = "${data.azurerm_subnet.wl_api_prd_subnet.network_security_group_id}"
}


resource "null_resource" "install_dotnetcore_sdk" {

  count = "${module.lhg-nux-api.nb_instances}"

  connection {
    type = "ssh"
    user = "${module.lhg-nux-api.vm_admin_user}"
    host = "${element(module.lhg-nux-api.host, count.index)}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg",
      "sudo mv microsoft.asc.gpg /etc/apt/trusted.gpg.d/",
      "wget -q https://packages.microsoft.com/config/debian/9/prod.list",
      "sudo mv prod.list /etc/apt/sources.list.d/microsoft-prod.list",
      "sudo chown root:root /etc/apt/trusted.gpg.d/microsoft.asc.gpg",
      "sudo chown root:root /etc/apt/sources.list.d/microsoft-prod.list",
      "sudo apt-get -y install apt-transport-https",
      "sudo apt-get update",
      "sudo apt-get -y install dotnet-sdk-2.2"
    ]
  }
}

