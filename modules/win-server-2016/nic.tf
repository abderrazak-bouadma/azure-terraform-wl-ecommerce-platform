resource "azurerm_network_interface" "nic" {
  count = "${var.nb_instances}"
  name = "nic-${var.vm_hostname_prefix}-${count.index}${var.vm_hostname_suffix}"
  location = "${var.location}"
  resource_group_name = "${var.rg}"

  "ip_configuration" {
    name = "ip_cfg_${var.vm_hostname_prefix}-${count.index}${var.vm_hostname_suffix}"
    private_ip_address_allocation = "Dynamic"
    subnet_id = "${var.subnet_id}"
    public_ip_address_id = "${var.public_ip_address_id != "" ? var.public_ip_address_id : ""}"
  }

  network_security_group_id = "${var.nsg_id}"
  tags = "${var.tags}"
}