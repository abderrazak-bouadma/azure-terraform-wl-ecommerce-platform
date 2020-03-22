terraform {
  backend "azurerm" {
    storage_account_name = "lhgmbstorageaccount"
    container_name = "tfstate"
    key = "cms.p.tfstate"
    access_key = ""
  }
}