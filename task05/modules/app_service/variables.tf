variable "name" {
  type        = string
  description = "Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "service_plan_id" {
  type        = string
  description = "App Service Plan Id"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "app_settings" {
  type        = map(string)
  description = "App Settings"
}


variable "app_allow_ip_rule" {
  type = list(object({
    name       = string
    ip_address = string
    priority   = number
    action     = optional(string, "Allow")
  }))
  description = "Access restriction allow IP rule"
}

variable "app_allow_tag_rule" {
  type = list(object({
    name        = string
    service_tag = string
    priority    = number
    action      = optional(string, "Allow")
  }))
  description = "Access restriction allow tag rule"
}

variable "ip_restriction_default_action" {
  type    = string
  default = "Deny"
  validation {
    condition     = contains(["Allows", "Deny"], var.ip_restriction_default_action)
    error_message = "ip_restriction_default_action must be Allow or Deny"
  }
}

