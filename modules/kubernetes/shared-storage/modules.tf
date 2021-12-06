resource "kubernetes_job" "iac-data" {
  metadata {
    name = "data"
  }
  spec {
    template {
      metadata {}
      spec {
        volume {
          name = "shared-pv"
          persistent_volume_claim {
            claim_name = var.pvc-name
          }
        }
        container {
          name    = "iac-data"
          image   = "google/cloud-sdk:344.0.0-slim"
          command = ["/bin/sh", "-c"]
          args = [<<EOT
            echo "Preparing shared storage for SeQuiLa";
            mkdir -p /mnt/data/;
            gsutil rsync gs://tbd-tbd-devel-staging/data/ /mnt/data/;
            echo "Finished rsync of shared storage"
            EOT
          ]

          volume_mount {
            mount_path = "/mnt/data"
            name       = "shared-pv"
          }
        }
        restart_policy = "Never"
      }
    }
    backoff_limit = 4

  }
  wait_for_completion = true
  timeouts {
    create = "60m"
    update = "60m"
  }
}