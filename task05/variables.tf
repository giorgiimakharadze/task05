variable "tags" {
  type = map(string)

  description = "Tags"
}

variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
  }))

  description = "Resource Groups"
}

variable "apps" {
  type = map(object({
    rg_key = string

    plan = object({
      name         = string
      sku_name     = string
      worker_count = number
      os_type      = string
    })

    app = object({
      name = string

      ip_restriction_default_action = string

      app_allow_ip_rule = list(object({
        name       = string
        ip_address = string
        priority   = number
        action     = string
      }))

      app_allow_tag_rule = list(object({
        name        = string
        service_tag = string
        priority    = number
        action      = string
      }))

      app_settings = map(string)
    })
  }))

  description = "For App Services and App Service Plans"
}

variable "traffic_manager" {
  type = object({
    rg_key            = string
    profile_name      = string
    dns_relative_name = string
    routing_method    = string
    ttl               = number
    monitor_protocol  = string
    monitor_port      = number
    monitor_path      = string

    endpoints = list(object({
      name     = string
      app_key  = string
      priority = optional(number)
      weight   = optional(number)
    }))
  })

  description = "For Traffic Manager"
}
