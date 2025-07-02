terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.17.0"
    }
  }
  backend "gcs" {
    # the bucket is configured through the config file, and the
    # command `terraform init --migrate-state --backend-config=config/gcp-pilot-us.config`
    prefix = "terraform/state"
  }
}

provider "google" {
  # Configuration options
  region = var.region
}

# FIXME: rename "db_name_suffix" to "rnd_name_suffix", needs to be done after a `destroy`, otherwise everything gets destroyed anyway
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

data "google_compute_global_address" "global_ip_k8s" {
  name    = var.app_lb_global_ip_name
  project = var.project_id
}

# Create LB backend buckets

resource "google_storage_bucket" "ng-frontend" {
  name                        = "${var.specific_name}ng-frontend-site"
  project                     = var.project_id
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
  // delete bucket and contents on destroy.
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "PATCH", "DELETE", "OPTIONS"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket" "web-engine" {
  name                        = "${var.specific_name}web-engine-site"
  project                     = var.project_id
  location                    = var.bucket_location
  uniform_bucket_level_access = true
  storage_class               = "STANDARD"
  // delete bucket and contents on destroy.
  force_destroy = true

  website {
    main_page_suffix = "index.html"
    not_found_page   = "index.html"
  }
  cors {
    origin          = ["*"]
    method          = ["GET", "HEAD", "PUT", "POST", "PATCH", "DELETE", "OPTIONS"]
    response_header = ["Content-Type"]
    max_age_seconds = 3600
  }
}

resource "google_compute_backend_bucket" "ng-frontend" {
  name        = "ngfrontend"
  description = "Main application angular for ng-frontend"
  bucket_name = google_storage_bucket.ng-frontend.name
  project     = var.project_id
  enable_cdn  = true
  cdn_policy {
    cache_key_policy {
      include_http_headers = ["X-Header-Field"] # FIXME: which ones do we need?
    }
  }
}

resource "google_compute_backend_bucket" "web-engine" {
  name        = "webengine"
  description = "Main application vue for web-engine"
  bucket_name = google_storage_bucket.web-engine.name
  project     = var.project_id
  enable_cdn  = true
  cdn_policy {
    cache_key_policy {
      include_http_headers = ["X-Header-Field"] # FIXME: which ones do we need?
    }
  }
}

data "google_compute_global_address" "global-lb-address" {
  name    = var.admin_bucket_lb_global_ip_name
  project = var.project_id
}

# Policy to make buckets public
data "google_iam_policy" "storage_object_viewer" {
  binding {
    role = "roles/storage.objectViewer"
    members = [
      "allUsers",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy-ng-1" {
  bucket      = google_storage_bucket.ng-frontend.name
  policy_data = data.google_iam_policy.storage_object_admin.policy_data
}

resource "google_storage_bucket_iam_policy" "policy-we-1" {
  bucket      = google_storage_bucket.web-engine.name
  policy_data = data.google_iam_policy.storage_object_admin.policy_data
}

resource "google_storage_bucket_iam_policy" "policy-we-3" {
  bucket      = google_storage_bucket.web-engine.name
  policy_data = data.google_iam_policy.storage_object_viewer.policy_data
}

resource "google_storage_bucket_iam_policy" "policy-ng-3" {
  bucket      = google_storage_bucket.ng-frontend.name
  policy_data = data.google_iam_policy.storage_object_viewer.policy_data
}

# Create url map
resource "google_compute_url_map" "default" {
  name    = "http-lb"
  project = var.project_id

  default_service = google_compute_backend_bucket.ng-frontend.id

  host_rule {
    hosts = [
      "ng-frontend.${var.dns_domain_name}",
      "admin.${var.dns_domain_name}",
    ]
    path_matcher = "path-matcher-ng-frontend"
  }

  host_rule {
    hosts        = ["web-engine.${var.dns_domain_name}"]
    path_matcher = "path-matcher-web-engine"
  }

  path_matcher {
    name            = "path-matcher-ng-frontend"
    default_service = google_compute_backend_bucket.ng-frontend.id
  }

  path_matcher {
    name            = "path-matcher-web-engine"
    default_service = google_compute_backend_bucket.web-engine.id
  }
}

resource "google_compute_managed_ssl_certificate" "default" {
  project = var.project_id
  name    = "global-lb-buckets-certificate"
  type    = "MANAGED"
  managed {
    # Note: these hostnames should appear as "NONE" in the DNS zone definitions in the other file
    domains = [
      "ng-frontend.${var.dns_domain_name}",
      "web-engine.${var.dns_domain_name}",
      "admin.${var.dns_domain_name}",
    ]
  }
}

# Create HTTPS target proxy
resource "google_compute_target_https_proxy" "default" {
  project = var.project_id
  name    = "global-lb-buckets-proxy"
  url_map = google_compute_url_map.default.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.default.id,
  ]
}

# Create forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  project               = var.project_id
  name                  = "http-lb-buckets-forwarding-rule"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED" # this makes it a global load-balancer
  port_range            = "443"
  target                = google_compute_target_https_proxy.default.id
  ip_address            = data.google_compute_global_address.global-lb-address.address
}

resource "google_storage_bucket" "files-site" {
  name          = "infra-tf-${var.specific_name}files-site"
  location      = var.bucket_location
  force_destroy = true
  project       = var.project_id

  uniform_bucket_level_access = true

  hierarchical_namespace {
    enabled = true
  }
  versioning {
    enabled = false
  }
}

data "google_iam_policy" "storage_object_admin" {
  binding {
    role = "roles/storage.objectAdmin"
    members = [
      "serviceAccount:...",
      "serviceAccount:...",
    ]
  }
}

resource "google_storage_bucket_iam_policy" "policy-files-1" {
  bucket      = google_storage_bucket.files-site.name
  policy_data = data.google_iam_policy.storage_object_admin.policy_data
}
