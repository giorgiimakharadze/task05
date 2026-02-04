variable "profile_name" {
  type        = string
  description = "Profile Name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "routing_method" {
  type = string

  validation {
    condition     = contains(["Performance", "Priority", "Weighted", "Geographic", "Multivalue", "Subnet"], var.routing_method)
    error_message = "Invalid routing_method"
  }
  description = "Routing Method"
}

variable "dns_relative_name" {
  type        = string
  description = "DNS name"
}

variable "ttl" {
  type        = number
  default     = 30
  description = "TTL"
}

variable "monitor_protocol" {
  type    = string
  default = "HTTPS"
  validation {
    condition     = contains(["HTTP", "HTTPS", "TCP"], var.monitor_protocol)
    error_message = "Invalid protocol"
  }
  description = "Monitor Protocol"
}

variable "monitor_port" {
  type        = number
  default     = 443
  description = "Monitor Port"
}
variable "monitor_path" {
  type    = string
  default = "/"

  description = "Monitor Path"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}


variable "endpoints" {
  type = list(object({
    name               = string
    target_resource_id = string
    priority           = optional(number)
    weight             = optional(number)
  }))
}
