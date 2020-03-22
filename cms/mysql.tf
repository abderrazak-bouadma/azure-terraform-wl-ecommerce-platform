resource "random_string" "mysql_admin_login" {
  length = 10
  number = false
  special = false
  upper = false
}

resource "random_string" "mysql_admin_password" {
  length = 16
  number = true
  special = true
  min_lower = 1
  min_numeric = 3
  min_special = 3
  min_upper = 3
}

resource "azurerm_mysql_server" "wl_mysql_server_p" {

  administrator_login = "${random_string.mysql_admin_login.result}"
  administrator_login_password = "${random_string.mysql_admin_password.result}"
  location = "${data.azurerm_resource_group.white_label_rg.location}"
  resource_group_name = "${data.azurerm_resource_group.white_label_rg.name}"

  name = "lhg-mysql-0p"

  sku {
    name     = "GP_Gen5_2"
    capacity = 2
    tier     = "GeneralPurpose"
    family   = "Gen5"
  }

  ssl_enforcement = "Disabled"

  "storage_profile" {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  tags = "${var.tags}"

  version = "5.7"
}

resource "azurerm_mysql_virtual_network_rule" "wl_mysql_server_vpc_rule" {
  name = "mysal-vpc-rule-0"
  resource_group_name = "${data.azurerm_resource_group.white_label_rg.name}"
  server_name = "${azurerm_mysql_server.wl_mysql_server_p.name}"
  subnet_id = "${data.azurerm_subnet.wl_mysql_prd_subnet.id}"
}

resource "null_resource" "deploy_db_server_creds_on_cms_env" {

  count = "${module.lhg-nux-cms.nb_instances}"

  connection {
    type = "ssh"
    user = "${module.lhg-nux-cms.vm_admin_user}"
    host = "${element(module.lhg-nux-cms.host, count.index)}"
    private_key = "${file("~/.ssh/id_rsa")}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir /home/${module.lhg-nux-cms.vm_admin_user}/.secrets",
      "echo \"MYSQL_SERVER_HOST=${azurerm_mysql_server.wl_mysql_server_p.fqdn}\" >> /home/${module.lhg-nux-cms.vm_admin_user}/.secrets/.mysql",
      "echo \"MYSQL_ADMIN_LOGIN=${azurerm_mysql_server.wl_mysql_server_p.administrator_login}\" >> /home/${module.lhg-nux-cms.vm_admin_user}/.secrets/.mysql",
      "echo \"MYSQL_ADMIN_PASSWORD=${azurerm_mysql_server.wl_mysql_server_p.administrator_login_password}\" >> /home/${module.lhg-nux-cms.vm_admin_user}/.secrets/.mysql",
      "chmod 600 /home/${module.lhg-nux-cms.vm_admin_user}/.secrets"
    ]
  }
}

output "mysql_server_host" {
  value = "${azurerm_mysql_server.wl_mysql_server_p.fqdn}"
}

output "mysql_server_admin_login" {
  value = "${azurerm_mysql_server.wl_mysql_server_p.administrator_login}"
}

output "mysql_server_admin_login_password" {
  value = "${azurerm_mysql_server.wl_mysql_server_p.administrator_login_password}"
}