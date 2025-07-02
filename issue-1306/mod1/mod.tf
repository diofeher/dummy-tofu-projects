variable "enable" {
  type    = bool
  default = false
}

resource "null_resource" "example" {
  # for_each = var.enable ? toset(local.users) : []
  # bucket = each.key
  lifecycle {
    enabled = var.enable
  }
}

output "output" {
  value = null_resource.example.id
}
#   #   value = try(null_resource.example.id, "default value")
#   #   value = can(null_resource.example.id) ? null_resource.example.id : "default value"
#   value = one(null_resource.example.id)
#   #   value = aws_s3_bucket.example.id
#   # value = can(null_resource.example.id) ? null_resource.example.id : "default value"
#   #   # value = null_resource.example != null ? null_resource.example.id : "default value"
#   #   # value = var.enable ? null_resource.example.id : "default value" # => only one that works 
#   #   # value = null_resource.example[*].id # => null
#   # value = try(null_resource.example.id) # => null
#   # value = one(null_resource.example[*].id) # => tostring(null)
#   #   # value = try(null_resource.example.id, "default value") # => null
#   #   # value = null != null ? null_resource.example.id : "default value" # null
#   #   # value = coalesce(null_resource.example[*].id, "default value") # => null
#   #   # value = var.enable ? null_resource.example.id : "default value"
#   #     # value = data.null_data_source.example1 != null ? data.null_data_source.example1.id : "default value" # => only one that works 
# }
