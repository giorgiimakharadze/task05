resource "azurerm_windows_web_app" "app" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id


  site_config {
    always_on = true

    ip_restriction_default_action = var.ip_restriction_default_action

    dynamic "ip_restriction" {
      for_each = { for r in var.app_allow_ip_rule : r.name => r }
      content {
        name       = ip_restriction.key
        priority   = ip_restriction.value.priority
        action     = try(ip_restriction.value.action, "Allow")
        ip_address = ip_restriction.value.ip_address
      }
    }

    dynamic "ip_restriction" {
      for_each = { for r in var.app_allow_tag_rule : r.name => r }

      content {
        name        = ip_restriction.key
        priority    = ip_restriction.value.priority
        action      = try(ip_restriction.value.action, "Allow")
        service_tag = ip_restriction.value.service_tag
      }
    }
  }

  app_settings = var.app_settings

  tags = var.tags
}
