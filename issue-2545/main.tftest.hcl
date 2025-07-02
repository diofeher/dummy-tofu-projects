provider "google" {
  project = "foo-testproject"
}

# run "fails" {
#   command = plan
#   plan_options {
#     refresh = false
#   }

#   assert {
#     condition = google_compute_backend_bucket.foo.custom_response_headers == [
#       "Test-Header-1: bar",
#       "Test-Header-2: bar",
#       "X-Foobar-Wizzle: baz",
#     ]
#     error_message = "Test."
#   }
# }

run "fails_without_useful_diff" {
  command = plan
  plan_options {
    refresh = false
  }

  assert {
    condition = jsonencode(google_compute_backend_bucket.foo.custom_response_headers) == jsonencode([
      "Test-Header-1: foo",
      "X-Foobar-Wizzle: baz",
    ])
    error_message = "Test."
  }
  assert {
    condition = length(google_compute_backend_bucket.foo.custom_response_headers) == 10
    error_message = "Testing from TF!!"
  }

  assert {
    # condition = var.name != "" && lower(var.name) == var.name
    # condition = contains(["STAGE", "PROD"], var.name)
    condition = can(regex("^[a-z]+$", var.name))
    error_message = "longer test condition"
  }
}

run "succeeds" {
  command = plan
  plan_options {
    refresh = false
  }

  assert {
    condition = jsonencode(google_compute_backend_bucket.foo.custom_response_headers) == jsonencode([
      "Test-Header-1: foo",
      "Test-Header-2: bar",
      "X-Foobar-Wizzle: baz",
    ])
    error_message = "Test."
  }
}
