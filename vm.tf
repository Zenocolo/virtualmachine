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

resource "azurerm_windows_virtual_machine" "virtual_machine" {
  name                  = "vm-${var.project_name}-${count.index}"
  location              = var.location
  resource_group_name   = var.rg-name
  network_interface_ids = [element(azurerm_network_interface.network_card.*.id, count.index)]
  size               = var.vmsize
  admin_username = var.username
  admin_password = var.password
  provision_vm_agent = true
  allow_extension_operations = true
  enable_automatic_updates = false
  #encryption_at_host_enabled = true
  # disk_encryption_set_id 
  count = var.vmcount

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }

  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  tags = local.tags
}

output "virtual_machine_ids" {
  value = azurerm_windows_virtual_machine.virtual_machine.*.id
}
