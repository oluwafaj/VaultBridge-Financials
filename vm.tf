resource "azurerm_linux_virtual_machine" "web-server" {
    name                = "vaultbridge-vm"
    resource_group_name = var.resource_group_name
    location            = var.location
    size                = "Standard_DS1_v2"
    admin_username      = "azureuser"
    network_interface_ids = [
        azurerm_network_interface.nic.id,
    ]
    admin_ssh_key {
        username   = "azureuser"
        public_key = var.ssh_public_key
    }
    
    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts-gen2"
      version   = "latest"
    }
}