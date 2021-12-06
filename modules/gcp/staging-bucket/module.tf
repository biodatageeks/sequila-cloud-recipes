resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.bucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket" "bucket" {
  project                     = var.project_name
  name                        = "${var.project_name}-staging"
  location                    = var.location
  uniform_bucket_level_access = false #tfsec:ignore:google-storage-enable-ubla
  force_destroy               = true
  #checkov:skip=CKV_GCP_62: "Bucket should log access"
  #checkov:skip=CKV_GCP_29: "Ensure that Cloud Storage buckets have uniform bucket-level access enabled"

}

resource "google_storage_bucket_object" "sequila-pileup" {

  name   = "jobs/pysequila/sequila-pileup.py"
  source = "jobs/gcp/dataproc/sequila-pileup.py"
  bucket = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_object" "sequila-pileup-gke" {

  name   = "jobs/pysequila/sequila-pileup-gke.py"
  source = "jobs/gcp/gke/sequila-pileup.py"
  bucket = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_object" "sequila-data" {
  for_each = toset(var.data_files)
  name     = "data/${each.value}"
  source   = "data/${each.value}"
  bucket   = google_storage_bucket.bucket.name
}

resource "google_storage_bucket_object" "sequila-init-script" {
  for_each = toset(var.data_files)
  name     = "scripts/setup-data.sh"
  source   = "scripts/setup-data.sh"
  bucket   = google_storage_bucket.bucket.name
}