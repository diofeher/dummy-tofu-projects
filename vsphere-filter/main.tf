terraform {
  required_providers {
    vsphere = {
      # https://github.com/vmware/terraform-provider-vsphere
      source  = "hashicorp/vsphere"
      version = "~> 2.12.0"
    }
  }
}

provider "vsphere" {
  vsphere_server       = "10.10.10.10"
  user                 = "administrator@vsphere.local"
  password             = "password"
  allow_unverified_ssl = true
}

variable "vsphere_network_list" {
  type = list(string)
  default = [
    "VM Network",
    "VM Network 2",
    "VM Network 3",
  ]
}

# { etc... }

data "vsphere_network" "nets" {
  for_each      = toset(var.vsphere_network_list)
  name          = each.value
  datacenter_id = "123"
  filter { # <-- LSP reports: `Unexpected block: Blocks of type "filter" are not expected here`
    network_type = "DistributedVirtualPortgroup"
  }
}
