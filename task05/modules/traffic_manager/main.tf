resource "azurerm_traffic_manager_profile" "traf" {
  name                   = var.profile_name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.routing_method

  dns_config {
    relative_name = var.dns_relative_name
    ttl           = var.ttl
  }

  monitor_config {
    protocol = var.monitor_protocol
    port     = var.monitor_port
    path     = var.monitor_path
  }

  tags = var.tags
}

resource "azurerm_traffic_manager_azure_endpoint" "endp" {
  for_each = { for ep in var.endpoints : ep.name => ep }

  name       = each.value.name
  profile_id = azurerm_traffic_manager_profile.traf.id

  target_resource_id = each.value.target_resource_id
  priority           = try(each.value.priority, null)
  weight             = try(each.value.weight, null)
}
