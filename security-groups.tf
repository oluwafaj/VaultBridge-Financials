resource "azurerm_network_security_group" "ssh" {
    name                = "nsg-ssh"
    location            = var.location
    resource_group_name = var.resource_group_name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "91.201.160.118/32"
        destination_address_prefix = "*"
    }

  
}

resource "azurerm_network_security_group" "HTTP" {
    name                = "nsg-http"
    location            = var.location
    resource_group_name = var.resource_group_name

    security_rule {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

}

resource "azurerm_network_security_group" "rds" {
    name                = "nsg-rds"
    location            = var.location
    resource_group_name = var.resource_group_name

    security_rule {
        name                       = "RDS"
        priority                   = 1003
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "5432"
        source_address_prefix      = "10.0.1.0/24"
        destination_address_prefix = "*"
    }
}