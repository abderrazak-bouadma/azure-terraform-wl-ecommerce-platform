resource "null_resource" "install_api_systemctl_service" {

  count = "${module.lhg-nux-api.nb_instances}"

  connection {
    type = "ssh"
    user = "${module.lhg-nux-api.vm_admin_user}"
    host = "${element(module.lhg-nux-api.host, count.index)}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "file" {
    source = "LH.Common.WebApi.service"
    destination = "/tmp/LH.Common.WebApi.service"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo useradd -m dotnetuser -p dotnetpass",
      "mkdir -p /home/${module.lhg-nux-api.vm_admin_user}/apps/WebApi",
      "sudo mv /tmp/LH.Common.WebApi.service /etc/systemd/system/",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable LH.Common.WebApi.service"
    ]
  }
}