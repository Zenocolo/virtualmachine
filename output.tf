output "virtual_machine_ids" {
  value = azurerm_windows_virtual_machine.virtual_machine.*.id
}
