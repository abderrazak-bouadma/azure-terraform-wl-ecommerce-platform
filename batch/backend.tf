terraform {
  backend "azurerm" {
    storage_account_name = "lhgmbstorageaccount"
    container_name = "tfstate"
    key = "batch.p.tfstate"
    access_key = ""
  }
}