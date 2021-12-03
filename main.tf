module "azure-databricks" {
  source         = "./modules/databricks/azure-workspace"
  project_prefix = var.azure-databricks-project_prefix
  sku            = var.azure-databricks-sku
  count          = var.azure-databricks-deploy ? 1 : 0
}

provider "databricks" {
  # Configuration options
  host = var.azure-databricks-deploy ? module.azure-databricks[0].workspace_url : ""
}

module "azure-databricks-sequila-job" {
  depends_on = [module.azure-databricks]
  source     = "./modules/databricks/databricks-job"
  count      = var.azure-databricks-deploy ? 1 : 0
}

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


