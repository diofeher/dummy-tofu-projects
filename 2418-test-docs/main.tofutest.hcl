run "http" {
  # Load the test helper instead of the main module:
  module {
    source = "git@github.com:diofeher/terraform-module-test.git"
  }

  # Check if the webserver returned an HTTP 200 status code:
  assert {
    condition     = local_file.test.filename == ".terraform/modules/test.main.tofutest.hcl.http/test.txt"
    error_message = "Incorrect filename returned: ${local_file.test.filename}"
  }
}
