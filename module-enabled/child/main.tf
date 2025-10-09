module "grandchild" {
  source          = "./grandchild"
  unrelated_field = "unrelated_field"
  # count  = 1

  # lifecycle {
  #   enabled = var.on
  # }

  # for_each = {
  #   for i in range(15) : i => i
  # }

}
