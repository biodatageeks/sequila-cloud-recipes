resource "google_project_service" "dataproc" {
  project                    = var.project_name
  service                    = "dataproc.googleapis.com"
  disable_dependent_services = true

}

resource "google_project_service" "workflowexecution" {
  project                    = var.project_name
  service                    = "workflowexecutions.googleapis.com"
  disable_dependent_services = true

}


resource "google_dataproc_workflow_template" "dataproc_workflow_template" {
  project  = var.project_name
  name     = "pysequila-workflow"
  location = var.location
  placement {
    managed_cluster {
      cluster_name = "${var.project_name}-cluster"
      config {
        gce_cluster_config {
          metadata = {
            "PIP_PACKAGES" = "pysequila==${var.pysequila_version}"
          }
          zone = var.zone
        }
        staging_bucket = var.bucket_name
        initialization_actions {
          executable_file   = "gs://goog-dataproc-initialization-actions-${var.location}/python/pip-install.sh"
          execution_timeout = "600s"
        }
        initialization_actions {
          executable_file   = "gs://${var.bucket_name}/scripts/setup-data.sh"
          execution_timeout = "600s"
        }
        master_config {
          num_instances = 1
          machine_type  = "n1-standard-2"
          disk_config {
            boot_disk_size_gb = 30
          }
        }
        worker_config {
          num_instances = 3
          machine_type  = "n1-standard-2"
          disk_config {
            boot_disk_size_gb = 30
          }
        }
        software_config {
          image_version = var.image_version
        }
      }
    }
  }
  jobs {
    step_id = "${var.project_name}-job"
    pyspark_job {
      properties = {
        "spark.jars.packages"     = "org.biodatageeks:sequila_2.12:${var.sequila_version},com.google.cloud:google-cloud-nio:0.123.16"
        "spark.jars.repositories" = "https://zsibio.ii.pw.edu.pl/nexus/repository/maven-snapshots/"
      }
      main_python_file_uri = var.main_python_file_uri
    }
  }
}