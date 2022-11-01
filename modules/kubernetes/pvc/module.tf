terraform {
  required_providers {
    kubernetes = "~> 2.7.0"
  }
}

resource "google_compute_disk" "data" {
  name = "data-${var.project_name}"
  type = "pd-standard"
  zone = var.zone
  size = var.volume_size_gb
}

resource "kubernetes_persistent_volume" "data" {
  metadata {
    name = "data-${var.project_name}"
  }
  spec {
    access_modes = ["ReadWriteMany"]
    capacity = {
      storage = "${var.volume_size_gb}Gi"
    }
    persistent_volume_source {
      gce_persistent_disk {
        pd_name = google_compute_disk.data.name
        fs_type = "ext4"
      }
    }
    storage_class_name = "standard"
  }
}




resource "kubernetes_persistent_volume_claim" "pvc" {
  metadata {
    name = "data"
  }
  spec {
    access_modes       = ["ReadWriteMany"]
    storage_class_name = var.storage_class
    resources {
      requests = {
        storage = "${var.volume_size_gb}Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.data.metadata[0].name
  }
}
