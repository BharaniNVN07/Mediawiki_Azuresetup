
data "azurerm_resource_group" "rg" {
  name = "${var.prefix}-rg"
}

data "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  resource_group_name = "${var.prefix}-rg"
}

data "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  resource_group_name = "${var.prefix}-rg"
}

data "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = "${var.prefix}-vnet"
  resource_group_name  = "${var.prefix}-rg"
}

data "azurerm_public_ip" "pip" {
  name                = "${var.prefix}-pip"
  resource_group_name = "${var.prefix}-rg"
}

data "template_file" "linux-vm-init" {
  template = file("nginx.sh")
}

# Generate random password
resource "random_password" "linux-vm-password" {
  length           = 12
  min_upper        = 2
  min_lower        = 2
  min_special      = 2
  number           = true
  special          = true
  override_special = "!@#$%&"
}

# SSH key
resource "tls_private_key" "linuxvm_privatekey" {
  algorithm = var.algo
  rsa_bits  = 4096
}

resource "azurerm_linux_virtual_machine" "vm" {
  depends_on=[data.azurerm_network_interface.nic]  
  name                  = "${var.prefix}-vm"
  location = var.location
  resource_group_name   = data.azurerm_resource_group.rg.name
  network_interface_ids = [data.azurerm_network_interface.nic.id]
  size                  = var.vm_size

  os_disk {
    name                 = var.vm_disk
    caching              = var.vm_caching
    storage_account_type = var.vm_storage_type
  }

  source_image_reference {
    publisher = var.vm_publisher
    offer     = var.vm_offer
    sku       = var.vm_sku
    version   = "latest"
  }

  computer_name                   = "${var.prefix}-vm"
  admin_username                  = var.vm_username
  admin_password                  = random_password.linux-vm-password.result
  custom_data    = base64encode(data.template_file.linux-vm-cloud-init.rendered)
  disable_password_authentication = false

  admin_ssh_key {
    username   = var.vm_username
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

}

# remote-exec provisoner - 1
resource "null_resource" "remote_install_1" {

    connection {
        type = "ssh"
        user = var.vm_username
        password = random_password.linux-vm-password.result
        host = data.azurerm_public_ip.pip.ip_address
        port = 22
    }
    provisioner "file" {
        source = "MariaDB.sh"
        destination = "/tmp/MariaDB.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/MariaDB.sh",
            "/bin/bash /tmp/MariaDB.sh dbadmin dbpassword"
        ]
    }
}

# remote-exec provisoner - 2
resource "null_resource" "remote_install_2" {

    connection {
        type = "ssh"
        user = var.vm_username
        password = random_password.linux-vm-password.result
        host = data.azurerm_public_ip.pip.ip_address
        port = 22
    }
    provisioner "file" {
        source = "Mediawiki.sh"
        destination = "/tmp/Mediawiki.sh"
    }

    provisioner "remote-exec" {
        inline = [
            "chmod +x /tmp/Mediawiki.sh",
            "/bin/bash /tmp/Mediawiki.sh"
        ]
    }
}
