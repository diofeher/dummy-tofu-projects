variable "foo" {
}
variable "cluster_name" {
  type = string
}

resource "tfcoremock_simple_resource" "main" {
  string = var.foo

  lifecycle {
    replace_triggered_by = [
      null_resource.kubernetes_cluster_name_keeper.id
    ]
    precondition {
      condition     = var.foo == "magic"
      error_message = "foo must be magical!"
    }

    precondition {
      condition     = var.foo == "magic"
      error_message = "foo must be magical!"
    }
  }
}

resource "null_resource" "kubernetes_cluster_name_keeper" {
  triggers = {
    name = var.cluster_name
  }
}
