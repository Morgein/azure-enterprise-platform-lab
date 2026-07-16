output "virtual_network_id" {
  description = "Resource ID of the Virtual Network."
  value       = azurerm_virtual_network.this.id
}

output "virtual_network_name" {
  description = "Name of the Virtual Network."
  value       = azurerm_virtual_network.this.name
}

output "virtual_network_address_space" {
  description = "CIDR address spaces assigned to the Virtual Network."
  value       = azurerm_virtual_network.this.address_space
}

output "subnet_ids" {
  description = "Subnet resource IDs keyed by logical subnet name."

  value = {
    for subnet_key, subnet in azurerm_subnet.this :
    subnet_key => subnet.id
  }
}

output "subnet_details" {
  description = "Non-sensitive subnet and Network Security Group details."

  value = {
    for subnet_key, subnet in azurerm_subnet.this :
    subnet_key => {
      id               = subnet.id
      name             = subnet.name
      address_prefixes = subnet.address_prefixes
      network_security_group_id = try(
        azurerm_network_security_group.this[subnet_key].id,
        null
      )
    }
  }
}

output "network_security_group_ids" {
  description = "Network Security Group resource IDs keyed by logical subnet name."

  value = {
    for subnet_key, network_security_group in azurerm_network_security_group.this :
    subnet_key => network_security_group.id
  }
}
