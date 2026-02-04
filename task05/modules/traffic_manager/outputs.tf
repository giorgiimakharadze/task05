output "traffic_manager_fqdn" {
  value       = azurerm_traffic_manager_profile.traf.fqdn
  description = "Azure Traffic Manager FQDN"
}
