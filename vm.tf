locals {
  eu-location       = var.location
  eu-resource-group = var.rg-name
  prefix            = "eu"
  tags = {
    environment = local.prefix
  }
}

resource "azurerm_network_interface" "network_card" {
  name                 = "nc-${var.project_name}-${count.index}"
  location             = var.location
  resource_group_name  = var.rg-name
  enable_ip_forwarding = true
  count = var.vmcount

  ip_configuration {
    name                          = "ipconfig-${var.project_name}-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "virtual_machine" {
  name                  = "${local.prefix}-vm-${var.project_name}-${count.index}"
  location              = var.location
  resource_group_name   = var.rg-name
  network_interface_ids = [element(azurerm_network_interface.network_card.*.id, count.index)]
  vm_size               = var.vmsize
  delete_os_disk_on_termination = true
  count = var.vmcount

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk-${local.prefix}-vm-${var.project_name}${count.index}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${local.prefix}-vm-${var.project_name}${count.index}"
    admin_username = var.username
    admin_password = var.password
    allowExtensionOperations= true
  }

  os_profile_windows_config {
    provision_vm_agent = true
  }

  tags = local.tags
}

output "virtual_machine_ids" {
  value = azurerm_virtual_machine.virtual_machine.*.id
}
