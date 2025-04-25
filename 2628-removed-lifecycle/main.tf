
# # resource "null_resource" "a" {
# # }


# removed {
#   from = null_resource.a

#   lifecycle {
#     destroy = true
#   }

#   provisioner "local-exec" {
#     when    = destroy
#     command = "echo 'Instance ${each.key} has been destroyed.'"
#     # command = "echo 'Instance ${self.id} has been destroyed.'"
#   }
# }

# resource "tfcoremock_simple_resource" "example" {
#   count = 2
#   id = "my-simple-resource-${count.index}"
#   string = "test-${count.index}"
# }

# removed {
#   from = tfcoremock_simple_resource.example

#   lifecycle {
#     destroy = true
#   }

#   provisioner "local-exec" {
#     when = destroy
#     command = "echo 'Instance ${self.id} has been destroyed.'"
#     # command = "echo 'Provisioner 1 against ${self.id} idx: ${count.index}'"
#   }
# }
