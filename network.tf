# Create a resource group
resource "azurerm_resource_group" "resourcegroup" {
  name = "${var.prefix}-rg"
  location = var.location
}

# Create the VNET
resource "azurerm_virtual_network" "vnet" {
  name = "${var.prefix}-vnet"
  address_space = [var.vnet_cidr]
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location = azurerm_resource_group.resourcegroup.location
}

# Create a subnet
resource "azurerm_subnet" "subnet" {
  name = "${var.prefix}-subnet"
  address_prefixes = [var.subnet_cidr]
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name = azurerm_resource_group.resourcegroup.name
}

# Create NSG
resource "azurerm_network_security_group" "nsg" {
  depends_on=[azurerm_resource_group.vnet]
  name = "${var.prefix}-nsg"
  location = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  security_rule {
    name                       = "AllowHTTP"
    description                = "Allow HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }
  security_rule {
    name                       = "AllowSSH"
    description                = "Allow SSH"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "VirtualNetwork"
  }
}

# Associate NSG with subnet
resource "azurerm_subnet_network_security_group_association" "mediawiki-nsg-association" {
  depends_on=[azurerm_resource_group.resourcegroup]
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Create Public IP
resource "azurerm_public_ip" "pip" {
  depends_on=[azurerm_resource_group.resourcegroup]
  name                = "${var.prefix}-pip"
  location = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method   = var.pip_allocation_method
}

# Create NIC
resource "azurerm_network_interface" "nic" {
  depends_on=[azurerm_resource_group.resourcegroup]
  name                = "${var.prefix}-nic"
  location = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

# Associate NSG with NIC
resource "azurerm_network_interface_security_group_association" "mediaiwki-nsg-nic-association" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
