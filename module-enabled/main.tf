module "child" {
  source = "./child"
}

terraform {
  required_version = ">= 1.0"
}

variable "clusters" {
  type    = list(string)
  default = ["cluster-1", "cluster-2", "cluster-3"]
}

provider "kubernetes" {
  for_each               = toset(var.clusters)
  alias                  = "kubernetes"
  host                   = "https://${module.kubernetes[each.key].cluster_endpoint}"
  cluster_ca_certificate = sensitive(base64decode(module.kubernetes[each.key].cluster_ca_certificate))
  token                  = sensitive(module.kubernetes[each.key].cluster_access_token)
}

module "service_account" {
  source   = "./service_account"
  for_each = module.kubernetes
  providers = {
    kubernetes = kubernetes.kubernetes[each.key]
  }
}
