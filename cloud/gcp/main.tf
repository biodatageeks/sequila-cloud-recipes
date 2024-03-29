
#### GCP: Storage
module "gcp-jobs-code" {
  source              = "../../modules/gcp/jobs-code"
  project_name        = var.project_name
  region              = var.region
  data_files          = var.data_files
  count               = (var.gcp-dataproc-deploy || var.gcp-gke-deploy) ? 1 : 0
  pysequila_version   = var.pysequila_version
  sequila_version     = var.sequila_version
  pysequila_image_gke = var.pysequila_image_gke
}


#### GCP: DATAPROC
module "gcp-dataproc-sequila-job" {
  depends_on           = [module.gcp-jobs-code]
  source               = "../../modules/gcp/dataproc-workflow-template"
  project_name         = var.project_name
  region               = var.region
  zone                 = var.zone
  main_python_file_uri = module.gcp-jobs-code[0].output_name
  bucket_name          = module.gcp-jobs-code[0].bucket_name.id
  sequila_version      = var.sequila_version
  pysequila_version    = var.pysequila_version
  count                = var.gcp-dataproc-deploy ? 1 : 0
}
resource "google_container_registry" "registry" {
  project  = var.project_name
  location = "EU"
  count    = var.gcp-dataproc-deploy ? 1 : 0
}



#### END GCP: DATAPROC

#### GCP: GKE
module "gke" {
  depends_on     = [module.gcp-jobs-code]
  source         = "../../modules/gcp/gke"
  project_name   = var.project_name
  zone           = var.zone
  machine_type   = var.gke_machine_type
  max_node_count = var.gke_max_node_count
  preemptible    = var.gke_preemptible
  bucket_name    = module.gcp-jobs-code[0].bucket_name.id
  count          = var.gcp-gke-deploy ? 1 : 0
}

#### END GCP: GKE


### KUBERNETES: SPARK
data "google_client_config" "default" {}

provider "helm" {
  alias = "gke"
  kubernetes {
    host                   = try(module.gke[0].endpoint, "")
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = try(module.gke[0].cluster_ca_certificate, "")
  }
}

provider "kubernetes" {
  alias                  = "gke"
  host                   = try("https://${module.gke[0].endpoint}", "")
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = try(module.gke[0].cluster_ca_certificate, "")
}


module "spark-on-k8s-operator-gke" {
  depends_on = [module.gke]
  source     = "../../modules/kubernetes/spark-on-k8s-operator"
  image_tag  = "v1beta2-1.2.3-3.1.2-aks"
  count      = var.gcp-gke-deploy ? 1 : 0
  providers = {
    helm = helm.gke
  }
}

### END KUBERNETES: SPARK