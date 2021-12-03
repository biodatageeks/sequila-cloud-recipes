terraform {
  required_providers {
    azurerm = "~> 2.33"
    random  = "~> 2.2"
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.11"
    }
  }
}


data "databricks_current_user" "me" {}
data "databricks_spark_version" "spark_version" {
  spark_version = var.spark_version
}
data "databricks_node_type" "smallest" {
  local_disk = true
}

resource "databricks_dbfs_file" "this" {
  source = "/Users/mwiewior/research/git/sequila/target/scala-2.12/sequila-assembly-0.7.4.jar"
  path   = "/tmp/sequila-assembly-0.7.4.jar"
}

resource "databricks_notebook" "this" {
  path     = "${data.databricks_current_user.me.home}/sequila-notebook"
  language = "PYTHON"
  source   = "${path.module}/sequila-pileup.py"
}

resource "databricks_job" "this" {
  name = "SeQuila Demo (${data.databricks_current_user.me.alphanumeric})"

  new_cluster {
    num_workers   = 1
    spark_version = data.databricks_spark_version.spark_version.id
    node_type_id  = data.databricks_node_type.smallest.id
  }

  notebook_task {
    notebook_path = databricks_notebook.this.path
  }
  library {
    jar = "dbfs:/tmp/sequila-assembly-0.7.4.jar"
  }

  library {
    pypi {
      package = "pysequila==${var.pysequila_version}"
    }
  }
}

