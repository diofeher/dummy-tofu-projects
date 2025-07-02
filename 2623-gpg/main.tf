terraform {}



# module "mod_remote" {
#   source   = "github.com/diofeher/terraform-module-test"
# }
data "http" "example_head" {
  url    = "http://localhost:8000/index.html"
  method = "GET"

    # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

output "test" {
  value = data.http.example_head.response_body
}
