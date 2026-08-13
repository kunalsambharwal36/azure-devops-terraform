resource "azurerm_storage_account" "main" {
  name                = "kmltfstorage001"
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

  min_tls_version = "TLS1_2"

  allow_nested_items_to_be_public = false
}

resource "azurerm_storage_container" "app" {
  name                  = "application-data"
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = "private"
}

resource "azurerm_storage_queue" "app" {
  name               = "app-queue"
  storage_account_id = azurerm_storage_account.main.id
}