terraform {
  backend "azurerm" {
    resource_group_name  = "test"
    storage_account_name = "opentofutest"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}


# created blobs with
# for i in $(seq 1 500); do az storage blob upload -c tfstate --name a-$i.txt --file a.txt --account-name opentofutest; done
