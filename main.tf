
#### GCP: Storage
module "gcp-staging-bucket" {
  source       = "./modules/gcp/staging-bucket"
  project_name = var.project_name
  region       = var.region
  data_files   = var.data_files
  count        = var.gcp-dataproc-deploy ? 1 : 0
}

#### Azure: Storage
module "azure-resources" {
  source = "./modules/azure/resource-mgmt"
  region = var.region
  count  = var.azure-aks-deploy ? 1 : 0
}

module "azure-staging-blob" {
  depends_on        = [module.azure-resources]
  source            = "./modules/azure/staging-blob"
  region            = var.region
  data_files        = var.data_files
  storage_account   = module.azure-resources[0].storage_account
  storage_container = module.azure-resources[0].azurerm_storage_container
  count             = var.azure-aks-deploy ? 1 : 0
}


#### GCP: DATAPROC
module "gcp-dataproc-sequila-job" {
  depends_on           = [module.gcp-staging-bucket]
  source               = "./modules/gcp/dataproc-workflow-template"
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
  source         = "./modules/gcp/gke"
  project_name   = var.project_name
  zone           = var.zone
  machine_type   = var.gke_machine_type
  max_node_count = var.gke_max_node_count
  preemptible    = var.gke_preemptible
  bucket_name    = module.gcp-staging-bucket[0].bucket_name.id
  count          = var.gcp-gke-deploy ? 1 : 0
}

#### END GCP: GKE

#### Azure: AKS
module "aks" {
  depends_on     = [module.azure-staging-blob]
  source         = "./modules/azure/aks"
  region         = var.region
  resource_group = module.azure-resources[0].resource_group
  count          = var.azure-aks-deploy ? 1 : 0
}

#### END Azure: GKS




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

provider "helm" {
  alias = "aks"
  debug = true
  kubernetes {
    host                   = try(module.aks[0].kube_config[0].host, "")
    username               = try(module.aks[0].kube_config[0].username, "")
    password               = try(module.aks[0].kube_config[0].password, "")
    client_certificate     = try(base64decode(module.aks[0].kube_config[0].client_certificate), "")
    client_key             = try(base64decode(module.aks[0].kube_config[0].client_key), "")
    cluster_ca_certificate = try(base64decode(module.aks[0].kube_config[0].cluster_ca_certificate), "")

  }
}

provider "kubernetes" {
  alias                  = "gke"
  host                   = try("https://${module.gke[0].endpoint}", "")
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = try(module.gke[0].cluster_ca_certificate, "")
}

provider "kubernetes" {
  alias                  = "aks"
  host                   = try(module.aks[0].kube_config[0].host, "")
  username               = try(module.aks[0].kube_config[0].username, "")
  password               = try(module.aks[0].kube_config[0].password, "")
  client_certificate     = try(base64decode(module.aks[0].kube_config[0].client_certificate), "")
  client_key             = try(base64decode(module.aks[0].kube_config[0].client_key), "")
  cluster_ca_certificate = try(base64decode(module.aks[0].kube_config[0].cluster_ca_certificate), "")
}



module "spark-on-k8s-operator-gke" {
  depends_on = [module.gke]
  source     = "./modules/kubernetes/spark-on-k8s-operator"
  count      = var.gcp-gke-deploy ? 1 : 0
  providers = {
    helm = helm.gke
  }
}

module "spark-on-k8s-operator-aks" {
  depends_on = [module.aks]
  source     = "./modules/kubernetes/spark-on-k8s-operator"
  count      = var.azure-aks-deploy ? 1 : 0
  image_tag  = "v1beta2-1.2.3-3.1.2-aks"
  providers = {
    helm = helm.aks
  }
}


module "persistent_volume-gke" {
  depends_on  = [module.gke]
  source      = "./modules/kubernetes/pvc"
  volume_size = var.volume_size
  count       = var.gcp-gke-deploy ? 1 : 0
  providers = {
    kubernetes = kubernetes.gke
  }
}

module "persistent_volume-aks" {
  depends_on    = [module.aks]
  source        = "./modules/kubernetes/pvc"
  volume_size   = var.volume_size
  count         = var.azure-aks-deploy ? 1 : 0
  storage_class = "azurefile"
  providers = {
    kubernetes = kubernetes.aks
  }
}

module "data-gke" {
  depends_on = [module.persistent_volume-gke]
  source     = "./modules/kubernetes/shared-storage"
  pvc-name   = module.persistent_volume-gke[0].pvc-name
  count      = var.gcp-gke-deploy ? 1 : 0
  providers = {
    kubernetes = kubernetes.gke
  }
}

module "data-aks" {
  depends_on      = [module.persistent_volume-aks]
  source          = "./modules/kubernetes/shared-storage"
  pvc-name        = module.persistent_volume-aks[0].pvc-name
  storage_account = module.azure-resources[0].storage_account
  count           = var.azure-aks-deploy ? 1 : 0
  providers = {
    kubernetes = kubernetes.aks
  }
}

### END KUBERNETES: SPARK