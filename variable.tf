variable "resource_group_name" {
  description = "The name of the resource group in which to create the resources."
  type        = string
  default     = "vaultbridge-financials-rg"
}

variable "location" {
  description = "The Azure Region where resources will be deployed."
  type        = string
  default     = "uksouth"
}

variable "vnet_cidr" {
  description = "The address space for the Virtual Network."
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "public_subnet_prefix" {
  description = "The address prefix for the public subnet."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "private_subnet_prefix" {
  description = "The address prefix for the private subnet."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "vm_size" {
  description = "The size of the Virtual Machine."
  type        = string
  default     = "Standard_B1s" # Similar to AWS t3.micro
}

variable "db_username" {
  description = "Administrator username for PostgreSQL."
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Administrator password for PostgreSQL."
  type        = string
  sensitive   = true
}
