include "root" {
  path = find_in_parent_folders("root.hcl")
}

dependency "foundation" {
  config_path = "../foundation"

  mock_outputs = {
    cluster_endpoint = "https://test.com"
    cluster_token = "test"
    cluster_certificate_authority_data = "test"
  }
}

inputs = {
  cluster_host = dependency.foundation.outputs.cluster_endpoint
  cluster_token = dependency.foundation.outputs.cluster_token
  cluster_certificate_authority_data = dependency.foundation.outputs.cluster_certificate_authority_data
}
