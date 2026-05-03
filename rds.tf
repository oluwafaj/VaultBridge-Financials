resource "azurerm_postgresql_flexible_server" "db" {
  name                = "vbf-flexible-server2"
  resource_group_name = var.resource_group_name
  location            = var.location
  delegated_subnet_id = "${azurerm_subnet.private_subnet1.id}"
  private_dns_zone_id = azurerm_private_dns_zone.psql_dns.id
  zone = "1"
  public_network_access_enabled = false
  version             = "15"
  administrator_login = "pgadmin"
  administrator_password = "P@ssw0rd1234"
  storage_mb         = 65536
  sku_name = "B_Standard_B1ms"
  
}