resource "kubernetes_persistent_volume_claim" "pvc" {
  metadata {
    name = "data"
  }
  spec {
    access_modes       = ["ReadOnlyMany"]
    storage_class_name = var.storage_class
    resources {
      requests = {
        storage = var.volume_size
      }
    }
  }
}