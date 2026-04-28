terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "<= 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

data "azurerm_resource_group" "existing_rg" {
  name = "<resource_group_name>" # Replace with your actual resource group name
}

# Create First Virtual Network (VNet1) in the existing resource group
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "test"
  }
}

data "azurerm_resource_group" "existing_rg" {
  name = "<resource_group_name>" # Replace with your actual resource group name
}

# Create First Virtual Network (VNet1) in the existing resource group
resource "azurerm_virtual_network" "vnet1" {
  name                = "vnet1"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    environment = "test"
  }
}


# Create Second Virtual Network (VNet2) in the existing resource group
resource "azurerm_virtual_network" "vnet2" {
  name                = "vnet2"
  location            = data.azurerm_resource_group.existing_rg.location
  resource_group_name = data.azurerm_resource_group.existing_rg.name
  address_space       = ["10.1.0.0/16"]

  tags = {
    environment = "test"
  }
}

# Peering from VNet1 to VNet2
resource "azurerm_virtual_network_peering" "vnet1_to_vnet2" {
  name                          = "vnet1-to-vnet2"
  resource_group_name           = data.azurerm_resource_group.existing_rg.name
  virtual_network_name          = azurerm_virtual_network.vnet1.name
  remote_virtual_network_id     = azurerm_virtual_network.vnet2.id
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  allow_virtual_network_access  = true
}

# Peering from VNet2 to VNet1
resource "azurerm_virtual_network_peering" "vnet2_to_vnet1" {
  name                          = "vnet2-to-vnet1"
  resource_group_name           = data.azurerm_resource_group.existing_rg.name
  virtual_network_name          = azurerm_virtual_network.vnet2.name
  remote_virtual_network_id     = azurerm_virtual_network.vnet1.id
  allow_forwarded_traffic       = true
  allow_gateway_transit         = false
  allow_virtual_network_access  = true
}
