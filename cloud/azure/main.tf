
#### Azure: Storage
module "azure-resources" {
  source = "../../modules/azure/resource-mgmt"
  region = var.region
  count  = var.azure-aks-deploy ? 1 : 0
}

module "azure-staging-blob" {
  depends_on        = [module.azure-resources]
  source            = "../../modules/azure/staging-blob"
  region            = var.region
  data_files        = var.data_files
  storage_account   = module.azure-resources[0].storage_account
  storage_container = module.azure-resources[0].azurerm_storage_container
  count             = var.azure-aks-deploy ? 1 : 0
}


#### Azure: AKS
module "aks" {
  depends_on     = [module.azure-staging-blob]
  source         = "../../modules/azure/aks"
  region         = var.region
  resource_group = module.azure-resources[0].resource_group
  count          = var.azure-aks-deploy ? 1 : 0
}

#### END Azure: GKS

### KUBERNETES: SPARK

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
  alias                  = "aks"
  host                   = try(module.aks[0].kube_config[0].host, "")
  username               = try(module.aks[0].kube_config[0].username, "")
  password               = try(module.aks[0].kube_config[0].password, "")
  client_certificate     = try(base64decode(module.aks[0].kube_config[0].client_certificate), "")
  client_key             = try(base64decode(module.aks[0].kube_config[0].client_key), "")
  cluster_ca_certificate = try(base64decode(module.aks[0].kube_config[0].cluster_ca_certificate), "")
}


module "spark-on-k8s-operator-aks" {
  depends_on = [module.aks]
  source     = "../../modules/kubernetes/spark-on-k8s-operator"
  count      = var.azure-aks-deploy ? 1 : 0
  image_tag  = "v1beta2-1.2.3-3.1.2-aks"
  providers = {
    helm = helm.aks
  }
}


module "persistent_volume-aks" {
  depends_on    = [module.aks]
  source        = "../../modules/kubernetes/pvc"
  volume_size   = var.volume_size
  count         = var.azure-aks-deploy ? 1 : 0
  storage_class = "azurefile"
  providers = {
    kubernetes = kubernetes.aks
  }
}

module "data-aks" {
  depends_on      = [module.persistent_volume-aks]
  source          = "../../modules/kubernetes/shared-storage"
  pvc-name        = module.persistent_volume-aks[0].pvc-name
  storage_account = module.azure-resources[0].storage_account
  count           = var.azure-aks-deploy ? 1 : 0
  providers = {
    kubernetes = kubernetes.aks
  }
}

### END KUBERNETES: SPARK