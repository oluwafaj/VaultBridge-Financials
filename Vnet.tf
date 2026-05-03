resource "azurerm_virtual_network" "vnet" {
    name                = "vnet-terraform"
    address_space       = var.vnet_cidr
    location            = var.location
    resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "public_subnet1" {
    name                 = "public-subnet1"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = var.public_subnet_prefix
}

resource "azurerm_subnet" "public_subnet2" {
    name                 = "public-subnet2"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.2.0/24"] 
  
}

resource "azurerm_subnet" "private_subnet1" {
    name                 = "private-subnet1"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.3.0/24"] 
  delegation{
    name = "fs-delegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action",
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_subnet" "private_subnet2" {
    name                 = "private-subnet2"
    resource_group_name  = var.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.4.0/24"] 
}

resource "azurerm_public_ip" "pip" {
    name                = "pip-terraform"
    location            = var.location
    resource_group_name = var.resource_group_name
    allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
    name                = "nic-terraform"
    location            = var.location
    resource_group_name = var.resource_group_name

    ip_configuration {
        name                          = "ipconfig1"
        subnet_id                     = azurerm_subnet.public_subnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.pip.id
    }
}

resource "azurerm_subnet_network_security_group_association" "public_subnet1_nsg_association" {
    subnet_id                 = azurerm_subnet.public_subnet1.id
    network_security_group_id = azurerm_network_security_group.ssh.id
  
}

resource "azurerm_private_dns_zone" "psql_dns" {
    name                = "privatelink.postgres.database.azure.com"
    resource_group_name = var.resource_group_name
  
}

resource "azurerm_private_dns_zone_virtual_network_link" "link" {
    name                  = "dns-link"
    resource_group_name   = var.resource_group_name
    private_dns_zone_name = azurerm_private_dns_zone.psql_dns.name
    virtual_network_id    = azurerm_virtual_network.vnet.id
}