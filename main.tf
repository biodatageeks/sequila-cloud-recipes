module "azure-databricks" {
  source         = "./modules/databricks/azure-workspace"
  project_prefix = var.azure-databricks-project_prefix
  sku            = var.azure-databricks-sku
  count          = var.azure-databricks-deploy ? 1 : 0
}

provider "databricks" {
  # Configuration options
  host = module.azure-databricks[0].workspace_url
}

module "sequila-job" {
  depends_on = [module.azure-databricks]
  source     = "./modules/databricks/databricks-job"
  count      = var.azure-databricks-deploy ? 1 : 0
}