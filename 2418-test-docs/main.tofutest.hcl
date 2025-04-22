run "http" {
  # Load the test helper instead of the main module:
  # Local module
  # module {
  #   source = "./test"
  # }
  # assert {
  #   condition     = local_file.test2.filename == "test/test.txt"
  #   error_message = "Incorrect filename returned: ${local_file.test2.filename}"
  # }

  # Load the test helper instead of the main module:
  # Registry module
  module {
    source = "infralicious/securityhub-batchupdatefindings/aws"
  }

  variables {
    default_product_arn = "1"
    findings = [
      {
        "id": "a",
        "note": {"text": "test"},
        "workflow": {"status": "test"}
      }
    ]
  }
  assert {
    condition     = local_file.test2.filename == "test/test.txt"
    error_message = "Incorrect filename returned: ${local_file.test2.filename}"
  }


  # Generic Git
  # module {
  #   source = "git@github.com:diofeher/terraform-module-test.git"
  # }
  # # Check if the webserver returned an HTTP 200 status code:
  # assert {
  #   condition     = local_file.test.filename == ".terraform/modules/test.main.tofutest.hcl.http/test.txt"
  #   error_message = "Incorrect filename returned: ${local_file.test.filename}"
  # }

  # Github source
  # module {
  #   source = "github.com/diofeher/terraform-module-test"
  # }
  # # Check if the webserver returned an HTTP 200 status code:
  # assert {
  #   condition     = local_file.test.filename == ".terraform/modules/test.main.tofutest.hcl.http/test.txt"
  #   error_message = "Incorrect filename returned: ${local_file.test.filename}"
  # }

  # Bitbucket Source
  # module {
  #   # source = "bitbucket.org/example-corp/tofu-consul-aws"
  #   source = "bitbucket.org/PSF/terraform-module-test"
  # }
  # Check if the webserver returned an HTTP 200 status code:
  # assert {
  #   condition     = local_file.test.filename == ".terraform/modules/test.main.tofutest.hcl.http/test.txt"
  #   error_message = "Incorrect filename returned: ${local_file.test.filename}"
  # }

  # Mercurial Source
  # module {
  #   source = "hg::ssh://diofeher@hg.code.sf.net/p/terraform-module-test/code1"
  # }
  # # Check if the webserver returned an HTTP 200 status code:
  # assert {
  #   condition     = local_file.test.filename == ".terraform/modules/test.main.tofutest.hcl.http/test.txt"
  #   error_message = "Incorrect filename returned: ${local_file.test.filename}"
  # }

  # HTTPS Source
  # module {
  #   source = "http://localhost:8000/terraform-module-test-main.zip"
  # }
  # # Check if the webserver returned an HTTP 200 status code:
  # assert {
  #   condition     = local_file.test.filename == ".terraform/modules/test.main.tofutest.hcl.http/test.txt"
  #   error_message = "Incorrect filename returned: ${local_file.test.filename}"
  # }

  # s3 Source
  # module {
  #   source = "s3://terraform-fireshell.s3.sa-east-1.amazonaws.com/terraform-module-test-main.zip"
  #   # source = "s3::s3-eu-west-1.amazonaws.com/examplecorp-tofu-modules/vpc.zip"
  # }
  # # Check if the webserver returned an HTTP 200 status code:
  # assert {
  #   condition     = local_file.test.filename == ".terraform/modules/test.main.tofutest.hcl.http/test.txt"
  #   error_message = "Incorrect filename returned: ${local_file.test.filename}"
  # }
}

