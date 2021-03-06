
#### GCP: Storage
module "gcp-staging-bucket" {
  source       = "../../modules/gcp/staging-bucket"
  project_name = var.project_name
  region       = var.region
  data_files   = var.data_files
  count        = (var.gcp-dataproc-deploy || var.gcp-gke-deploy) ? 1 : 0
}


#### GCP: DATAPROC
module "gcp-dataproc-sequila-job" {
  depends_on           = [module.gcp-staging-bucket]
  source               = "../../modules/gcp/dataproc-workflow-template"
  project_name         = var.project_name
  region               = var.region
  zone                 = var.zone
  main_python_file_uri = module.gcp-staging-bucket[0].output_name
  bucket_name          = module.gcp-staging-bucket[0].bucket_name.id
  sequila_version      = var.sequila_version
  pysequila_version    = var.pysequila_version
  count                = var.gcp-dataproc-deploy ? 1 : 0
}

#### END GCP: DATAPROC

#### GCP: GKE
module "gke" {
  depends_on     = [module.gcp-staging-bucket]
  source         = "../../modules/gcp/gke"
  project_name   = var.project_name
  zone           = var.zone
  machine_type   = var.gke_machine_type
  max_node_count = var.gke_max_node_count
  preemptible    = var.gke_preemptible
  bucket_name    = module.gcp-staging-bucket[0].bucket_name.id
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
  count      = var.gcp-gke-deploy ? 1 : 0
  providers = {
    helm = helm.gke
  }
}



module "persistent_volume-gke" {
  depends_on    = [module.gke]
  source        = "../../modules/kubernetes/pvc"
  volume_size   = var.volume_size
  storage_class = "standard"
  count         = var.gcp-gke-deploy ? 1 : 0
  providers = {
    kubernetes = kubernetes.gke
  }
}



module "data-gke" {
  depends_on  = [module.persistent_volume-gke]
  source      = "../../modules/kubernetes/shared-storage"
  pvc-name    = module.persistent_volume-gke[0].pvc-name
  bucket_name = module.gcp-staging-bucket[0].bucket_name.id
  count       = var.gcp-gke-deploy ? 1 : 0
  providers = {
    kubernetes = kubernetes.gke
  }
}

### END KUBERNETES: SPARK