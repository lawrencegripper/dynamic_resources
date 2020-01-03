resource "random_string" "dynamic" {
  length           = 8
  override_special = "-_"
}

resource "random_string" "unique_id" {
  length  = 10
  special = false
}

resource "azurerm_resource_group" "dynamic" {
  name     = format("rg_test_%s", random_string.dynamic.result)
  location = var.location
}

module "dynamic" {
  source              = "../"
  resource_group_name = azurerm_resource_group.dynamic.name
  storage_mapping     = var.storage_mapping
  unique_id           = lower(random_string.unique_id.result)
}