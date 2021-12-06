resource "kubernetes_persistent_volume_claim" "pvc" {
  metadata {
    name = "data"
  }
  spec {
    access_modes = ["ReadOnlyMany"]
    resources {
      requests = {
        storage = var.volume_size
      }
    }
  }
}