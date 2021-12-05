module "gcp-staging-bucket" {
  source       = "./modules/gcp/staging-bucket"
  project_name = var.project_name
  location     = var.location
  data_files   = var.data_files
  count        = var.gcp-dataproc-deploy || var.gcp-gke-deploy ? 1 : 0
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

module "gke" {
  depends_on     = [module.gcp-staging-bucket]
  source         = "./modules/gcp/gke"
  project_name   = var.project_name
  zone           = var.zone
  machine_type   = var.gke_machine_type
  max_node_count = var.gke_max_node_count
  preemptible    = var.gke_preemptible
  count          = var.gcp-gke-deploy ? 1 : 0
}

data "google_client_config" "default" {}

provider "helm" {
  kubernetes {
    host                   = module.gke[0].endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = module.gke[0].cluster_ca_certificate
  }
}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = module.gke.cluster_ca_certificate
}

module "spark-on-k8s-operator" {
  depends_on = [module.gke]
  source     = "./modules/spark-on-k8s-operator"
  count      = var.gcp-gke-deploy ? 1 : 0
}