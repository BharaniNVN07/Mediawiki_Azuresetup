
################# Environement Variables ###############
$ export ARM_CLIENT_ID=""
$ export ARM_CLIENT_SECRET=""
$ export ARM_SUBSCRIPTION_ID=""
$ export ARM_TENANT_ID=""
#########################################################

data "azurerm_client_config" "current" {}
# General varaibles

variable "prefix" {
    type = string
    description = "project prefix"
}

variable "subscription_id" {
  type        = string
  description = "azure subscription id"
}

variable "client_id" {
  type        = string
  description = "azure client id"
}

variable "client_secret" {
  type        = string
  description = "azure client secret"
  sensitive   = true
}

variable "tenant_id" {
  type        = string
  description = "azure tenant id"
}

variable "location" {
  type        = string
  description = "azure deployment location"
}

# Network Variables

variable "vnet_cidr" {
  type        = string
  description = "azure vnet"
}

variable "subnet_cidr" {
  type        = string
  description = "azure subent"
}

variable "pip_allocation_method" {
    type = string
    description = "mediawiki ip allocation"
}

# Compute Variables

variable "algo" {
    type = string
    description = "vm private key algorithm"
}

variable "vm_publisher" {
    type = string
    description = "vm publisher"
}

variable "vm_offer" {
    type = string
    description = "vm offer"
}

variable "vm_sku" {
    type = string
    description = "vm sku"
}

variable "vm_size" {
    type = string
    description = "vm size"
}

variable "vm_disk" {
    type = string
    description = "vm disk"
}

variable "vm_caching" {
    type = string
    description = "vm caching"
}

variable "vm_storage_type" {
    type = string
    description = "vm disk storage account type"
}

variable "vm_name" {
    type = string
    description = "vm name"
}

variable "vm_username" {
    type = string
    description = "vm username"
}


