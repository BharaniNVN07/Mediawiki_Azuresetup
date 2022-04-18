terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.46.0"
      #version = "~>2.46"
      #version = 2.97.0
    }
  }
    backend "azurerm" {
        resource_group_name = "Az_ResourceGroup"
        strorage_account_name = "Az_stoargeaccount"
        container_name = "Az_conatiner"
        key = "terraform.tfstate"
      }

}
    
provider "azurerm" {
  client_id       = var.client_id
  client_secret   = var.client_secret
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
    
    features {}
}