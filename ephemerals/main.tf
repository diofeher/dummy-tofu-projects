ephemeral "random_password" "db_password" {
  for_each = {
    "db_password" = "db_password"
  }
  length           = 16
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  db_password = ephemeral.random_password.db_password["db_password"].result
}
