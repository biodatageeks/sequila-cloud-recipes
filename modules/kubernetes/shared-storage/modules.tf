terraform {
  required_providers {
    kubernetes = "~> 2.7.0"
  }
}

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
            apt-get install -y wget;
            mkdir -p /mnt/data/;
            cd /mnt/data/;
            wget https://${var.storage_account}.blob.core.windows.net/sequila/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta || true;
            wget https://${var.storage_account}.blob.core.windows.net/sequila/data/Homo_sapiens_assembly18_chr1_chrM.small.fasta.fai || true;
            gsutil rsync gs://${var.bucket_name}/data/ /mnt/data/ || true;
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