terraform {
  backend "azurerm" {
    storage_account_name = "vbfstateterraformiac"
container_name = "tfstate"
key = "terraform.tfstate"
resource_group_name = "vaultbridge-financials-rg"
  }
}