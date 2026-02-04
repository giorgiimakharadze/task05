tags = {
  "Creator" = "giorgi_makharadze@epam.com"
}

resource_groups = {
  rg1 = {
    name     = "cmaz-2lfxdvp4-mod5-rg-01"
    location = "East US"
  }
  rg2 = {
    name     = "cmaz-2lfxdvp4-mod5-rg-02"
    location = "West Europe"
  }
  rg3 = {
    name     = "cmaz-2lfxdvp4-mod5-rg-03"
    location = "Central US"
  }
}


apps = {
  app1 = {
    rg_key = "rg1"

    plan = {
      name         = "cmaz-2lfxdvp4-mod5-asp-01"
      worker_count = 2
      sku_name     = "S1"
      os_type      = "Windows"
    }

    app = {
      name = "cmaz-2lfxdvp4-mod5-app-01"

      ip_restriction_default_action = "Deny"

      app_allow_ip_rule = [
        {
          name       = "allow-ip"
          ip_address = "18.153.146.156/32"
          priority   = 110
          action     = "Allow"
        }
      ]

      app_allow_tag_rule = [
        {
          name        = "allow-tm"
          service_tag = "AzureTrafficManager"
          priority    = 100
          action      = "Allow"
        }
      ]

      app_settings = {}
    }
  }

  app2 = {
    rg_key = "rg2"

    plan = {
      name         = "cmaz-2lfxdvp4-mod5-asp-02"
      worker_count = 1
      sku_name     = "S1"
      os_type      = "Windows"
    }

    app = {
      name = "cmaz-2lfxdvp4-mod5-app-02"

      ip_restriction_default_action = "Deny"

      app_allow_ip_rule = [
        {
          name       = "allow-ip"
          ip_address = "18.153.146.156/32"
          priority   = 110
          action     = "Allow"
        }
      ]

      app_allow_tag_rule = [
        {
          name        = "allow-tm"
          service_tag = "AzureTrafficManager"
          priority    = 100
          action      = "Allow"
        }
      ]

      app_settings = {}
    }
  }
}


traffic_manager = {
  rg_key            = "rg3"
  profile_name      = "cmaz-2lfxdvp4-mod5-traf"
  dns_relative_name = "cmaz-2lfxdvp4-mod5-traf"
  routing_method    = "Performance"


  ttl              = 30
  monitor_protocol = "HTTPS"
  monitor_path     = "/"

  endpoints = [
    {
      name          = "app1-endpoint"
      app_stack_key = "app1"
    },
    {
      name          = "app2-endpoint"
      app_stack_key = "app2"
    }
  ]
}
