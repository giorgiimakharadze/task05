variable "name" {
  type        = string
  description = "App Service name"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "os_type" {
  type    = string
  default = "Windows"
  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "os_type must be Windows or Linux"
  }
  description = "OS type"
}

variable "sku_name" {
  type        = string
  description = "SKU name"
}

variable "worker_count" {
  type    = number
  default = 1
  validation {
    condition     = var.worker_count >= 1
    error_message = "worker_count must be greater or equal to 1"
  }

  description = "Worker Count"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

