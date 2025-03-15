
check "kafka_cluster_health" {
  data "http" "tofu" {
    url = "https://opentofu.org/"
  }

  assert {
    condition     = data.http.tofu.status_code == 200
    error_message = "${data.http.tofu.url} returned an unhealthy status code"
  }
}

# # Valid config
# resource "null_resource" "b" {
# }


# resource "null_resource" "a" {
#   connection {
#     host = null_resource.b.id
#   }
# }
