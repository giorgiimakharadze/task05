module "resource_groups" {
  for_each = var.resource_groups

  source   = "./modules/resource_group"
  name     = each.value.name
  location = each.value.location
  tags     = var.tags
}

module "service_plans" {
  for_each = var.apps

  source              = "./modules/app_service_plan"
  name                = each.value.plan.name
  resource_group_name = module.resource_groups[each.value.rg_key].name
  location            = module.resource_groups[each.value.rg_key].location

  os_type      = each.value.plan.os_type
  sku_name     = each.value.plan.sku_name
  worker_count = each.value.plan.worker_count

  tags = var.tags
}

module "web_apps" {
  for_each = var.apps

  source              = "./modules/app_service"
  name                = each.value.app.name
  resource_group_name = module.resource_groups[each.value.rg_key].name
  location            = module.resource_groups[each.value.rg_key].location
  service_plan_id     = module.service_plans[each.key].id
  tags                = var.tags

  ip_restriction_default_action = each.value.app.ip_restriction_default_action
  app_allow_ip_rule             = each.value.app.app_allow_ip_rule
  app_allow_tag_rule            = each.value.app.app_allow_tag_rule
  app_settings                  = each.value.app.app_settings
}

module "traffic_manager" {
  source              = "./modules/traffic_manager"
  profile_name        = var.traffic_manager.profile_name
  resource_group_name = module.resource_groups[var.traffic_manager.rg_key].name

  routing_method    = var.traffic_manager.routing_method
  dns_relative_name = var.traffic_manager.dns_relative_name
  ttl               = var.traffic_manager.ttl

  monitor_protocol = var.traffic_manager.monitor_protocol
  monitor_port     = var.traffic_manager.monitor_port
  monitor_path     = var.traffic_manager.monitor_path

  endpoints = [
    for ep in var.traffic_manager.endpoints : {
      name               = ep.name
      target_resource_id = module.web_apps[ep.app_key].id
      priority           = try(ep.priority, null)
      weight             = try(ep.weight, null)
    }
  ]

  tags = var.tags
}
