output "output_name" {
  value = "gs://${google_storage_bucket_object.sequila-pileup.bucket}/${google_storage_bucket_object.sequila-pileup.output_name}"
}

output "bucket_name" {
  value = google_storage_bucket.bucket
}