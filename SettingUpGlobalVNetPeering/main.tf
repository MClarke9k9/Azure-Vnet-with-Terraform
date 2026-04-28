# Sets the required Terraform and Azure provider versions for the deployment.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# Defines variables for resource group name and location, with a default for the location.
variable "resource_group_name" {
  type = string
}

variable "location" {
  type    = string
  default = "East US"
}

# Creates two virtual networks in different Azure regions (East US and West Europe).
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet-eastus"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet-westeurope"
  location            = "West Europe"
  resource_group_name = var.resource_group_name
  address_space       = ["10.1.0.0/16"]
}

# Creates one subnet in each virtual network.
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet-eastus"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet-westeurope"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet2.name
  address_prefixes     = ["10.1.1.0/24"]
}

# Establishes bidirectional peering between the two VNets.
resource "azurerm_virtual_network_peering" "peering1" {
  name                         = "vnet1-to-vnet2"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet2.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "peering2" {
  name                         = "vnet2-to-vnet1"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id    = azurerm_virtual_network.vnet1.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}
