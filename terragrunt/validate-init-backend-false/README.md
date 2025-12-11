Minimal example repository to reproduce one bug that I found while using `init --all -- -backend=false`

```
➜  validate-init-backend-false git:(main) ✗ terragrunt run init --all -- -backend=false
17:05:54.141 INFO   Using runner pool for stack .
17:05:54.149 INFO   The runner-pool runner at . will be processed in the following order for command init:
- Unit ./foundation
- Unit ./cluster

17:05:54.210 STDOUT [foundation] tofu: Initializing provider plugins...
17:05:54.211 STDOUT [foundation] tofu: OpenTofu has been successfully initialized!
17:05:54.211 STDOUT [foundation] tofu:
17:05:54.211 STDOUT [foundation] tofu: You may now begin working with OpenTofu. Try running "tofu plan" to see
17:05:54.211 STDOUT [foundation] tofu: any changes that are required for your infrastructure. All OpenTofu commands
17:05:54.211 STDOUT [foundation] tofu: should now work.
17:05:54.211 STDOUT [foundation] tofu: If you ever set or change modules or backend configuration for OpenTofu,
17:05:54.211 STDOUT [foundation] tofu: rerun this command to reinitialize your working directory. If you forget, other
17:05:54.211 STDOUT [foundation] tofu: commands will detect it and remind you to do so if necessary.
╷
│ Error: Backend initialization required, please run "tofu init"
│
│ Reason: Initial configuration of the requested backend "s3"
│
│ The "backend" is the interface that OpenTofu uses to store state,
│ perform operations, etc. If this message is showing up, it means that the
│ OpenTofu configuration you're using is using a custom configuration for
│ the OpenTofu backend.
│
│ Changes to backend configurations require reinitialization. This allows
│ OpenTofu to set up the new configuration, copy existing state, etc. Please
│ run
│ "tofu init" with either the "-reconfigure" or "-migrate-state" flags to
│ use the current configuration.
│
│ If the change reason above is incorrect, please verify your configuration
│ hasn't changed and try again. At this point, no changes to your existing
│ configuration or state have been made.
╵
17:05:59.282 ERROR  [cluster] Error: Unknown variable
17:05:59.282 ERROR  [cluster]   on ./cluster/terragrunt.hcl line 16:
17:05:59.282 ERROR  [cluster]   16:   cluster_host = dependency.foundation.outputs.cluster_endpoint
17:05:59.282 ERROR  [cluster] There is no variable named "dependency".
17:05:59.282 ERROR  [cluster] Error: Unknown variable
17:05:59.282 ERROR  [cluster]   on ./cluster/terragrunt.hcl line 17:
17:05:59.282 ERROR  [cluster]   17:   cluster_token = dependency.foundation.outputs.cluster_token
17:05:59.282 ERROR  [cluster] There is no variable named "dependency".
17:05:59.282 ERROR  [cluster] Error: Unknown variable
17:05:59.282 ERROR  [cluster]   on ./cluster/terragrunt.hcl line 18:
17:05:59.282 ERROR  [cluster]   18:   cluster_certificate_authority_data = dependency.foundation.outputs.cluster_certificate_authority_data
17:05:59.282 ERROR  [cluster] There is no variable named "dependency".
17:05:59.283 ERROR  Run failed: 2 errors occurred:

* Failed to execute "tofu output -json" in ./foundation/.terragrunt-cache/2086713404
  ╷
  │ Error: Backend initialization required, please run "tofu init"
  │
  │ Reason: Initial configuration of the requested backend "s3"
  │
  │ The "backend" is the interface that OpenTofu uses to store state,
  │ perform operations, etc. If this message is showing up, it means that the
  │ OpenTofu configuration you're using is using a custom configuration for
  │ the OpenTofu backend.
  │
  │ Changes to backend configurations require reinitialization. This allows
  │ OpenTofu to set up the new configuration, copy existing state, etc. Please
  │ run
  │ "tofu init" with either the "-reconfigure" or "-migrate-state" flags to
  │ use the current configuration.
  │
  │ If the change reason above is incorrect, please verify your configuration
  │ hasn't changed and try again. At this point, no changes to your existing
  │ configuration or state have been made.
  ╵

  exit status 1

* ./cluster/terragrunt.hcl:16,18-28: Unknown variable; There is no variable named "dependency"., and 2 other diagnostic(s)


❯❯ Run Summary  2 units  5s
   ────────────────────────────
   Succeeded    1
   Failed       1
```