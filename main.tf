module "gcp-staging-bucket" {
  source       = "./modules/gcp/staging-bucket"
  project_name = var.project_name
  location     = var.location
  data_files   = var.data_files
  count        = var.gcp-dataproc-deploy ? 1 : 0
}

module "gcp-dataproc-sequila-job" {
  depends_on           = [module.gcp-staging-bucket]
  source               = "./modules/gcp/dataproc-workflow-template"
  project_name         = var.project_name
  location             = var.location
  zone                 = var.zone
  main_python_file_uri = module.gcp-staging-bucket.0.output_name
  bucket_name          = module.gcp-staging-bucket.0.bucket_name.id
  sequila_version      = var.sequila_version
  pysequila_version    = var.pysequila_version
  count                = var.gcp-dataproc-deploy ? 1 : 0
}


