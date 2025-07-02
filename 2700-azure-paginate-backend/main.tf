terraform {
  backend "azurerm" {
    resource_group_name  = "test"
    storage_account_name = "opentofutest"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
    timeout_seconds      = 1
  }
}


# created blobs with
# for i in $(seq 1 10000); do az storage blob upload -c tfstate --name prod.terraform.tfstateenv:env$i --file a.txt --account-name opentofutest; done
