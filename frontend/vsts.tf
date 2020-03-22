data "azurerm_key_vault" "vault" {
  name = "wl-p-vault"
  resource_group_name = "white_label_rg"
}

data "azurerm_key_vault_secret" "vsts_pat" {
  name = "vsts_agent_pat"
  vault_uri = "${data.azurerm_key_vault.vault.vault_uri}"
}

variable "vsts_deployment_group" {
  default = "whitelabel-frontend-p"
}

resource "null_resource" "install_vsts_agent" {


  count = "${module.lhg-nux-frontend.nb_instances}"

  connection {
    type = "ssh"
    user = "${module.lhg-nux-frontend.vm_admin_user}"
    host = "${element(module.lhg-nux-frontend.host, count.index)}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir azagent;cd azagent;curl -fkSL -o vstsagent.tar.gz https://vstsagentpackage.azureedge.net/agent/2.149.2/vsts-agent-linux-x64-2.149.2.tar.gz;tar -zxvf vstsagent.tar.gz; if [ -x \"$(command -v systemctl)\" ]; then ./config.sh --deploymentpool --deploymentpoolname \"${var.vsts_deployment_group}\" --acceptteeeula --agent $HOSTNAME --url https://louvre-hotels.visualstudio.com/ --work _work --auth PAT --token ${data.azurerm_key_vault_secret.vsts_pat.value} --runasservice; sudo ./svc.sh install --unattended; sudo ./svc.sh start; else ./config.sh --deploymentpool --deploymentpoolname \"${var.vsts_deployment_group}\" --acceptteeeula --agent $HOSTNAME --url https://louvre-hotels.visualstudio.com/ --work _work --auth PAT --token ${data.azurerm_key_vault_secret.vsts_pat.value}; ./run.sh; fi"
    ]

  }

}