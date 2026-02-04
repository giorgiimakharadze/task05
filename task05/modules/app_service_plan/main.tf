resource "azurerm_service_plan" "asp" {
  name = var.name

  resource_group_name = var.resource_group_name

  location = var.location

  os_type  = var.os_type
  sku_name = var.sku_name

  worker_count = var.worker_count

  tags = var.tags
}
