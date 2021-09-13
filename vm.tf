locals {
  eu-location       = var.location
  eu-resource-group = var.rg-name
  prefix-eu         = "eu"
  tags_eu = {
    environment = local.prefix-eu
  }
}

resource "azurerm_network_interface" "eu-nic-project1" {
  name                 = "nic-project1"
  location             = var.location
  resource_group_name  = var.rg-name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "ipconfig-project1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "eu-vm-project1" {
  name                  = "${local.prefix-eu}-vm-project1"
  location              = var.location
  resource_group_name   = var.rg-name
  network_interface_ids = [azurerm_network_interface.eu-nic-project1.id]
  vm_size               = var.vmsize
  delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk-project1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${local.prefix-eu}-vm-project1"
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = local.tags_eu
}
