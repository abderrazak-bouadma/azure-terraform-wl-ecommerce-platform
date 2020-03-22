resource "null_resource" "install_docker" {

  count = "${module.lhg-nux-batch.nb_instances}"

  connection {
    type = "ssh"
    user = "${module.lhg-nux-batch.vm_admin_user}"
    host = "${element(module.lhg-nux-batch.host, count.index)}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get -y install apt-transport-https",
      "sudo apt-get -y install ca-certificates",
      "sudo apt-get -y install curl",
      "sudo apt-get -y install gnupg2",
      "sudo apt-get -y install software-properties-common",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -",
      "sudo apt-key fingerprint 0EBFCD88",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get -y install docker-ce docker-ce-cli containerd.io",
      "sudo docker login -u ${data.azurerm_container_registry.acr.admin_username} -p ${data.azurerm_container_registry.acr.admin_password} ${data.azurerm_container_registry.acr.login_server}"
    ]
  }
}