provider "google" {
  project = "foo-testproject"
}

variable "name" {
  default = "Foo"
  type    = string
}

resource "google_storage_bucket" "foo" {
  name                        = "foo"
  location                    = "US"
  uniform_bucket_level_access = true
}

resource "google_compute_backend_bucket" "foo" {
  name        = "foo"
  bucket_name = google_storage_bucket.foo.name
  enable_cdn  = true

  custom_response_headers = [
    "Test-Header-1: foo",
    "Test-Header-2: bar",
    "X-Foobar-Wizzle: baz",
  ]
}
