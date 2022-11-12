locals {
  pysequila_setup_file = <<-EOT
  #!/usr/bin/env bash
  /usr/bin/miniforge/envs/py38/bin/pip install pysequila==${var.pysequila_version}
  EOT

  spark_setup_file = <<-EOT
  #!/usr/bin/env bash
  cd /opt && rm -rf spark && \
    wget https://archive.apache.org/dist/spark/spark-${var.spark_version}/spark-${var.spark_version}-bin-hadoop3.2.tgz && \
    tar zxvf spark-${var.spark_version}-bin-hadoop3.2.tgz && mv spark-${var.spark_version}-bin-hadoop3.2 spark
  chmod 777 -R /opt/spark/
  cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/microsoft/azure/azure-storage/7.0.1/azure-storage-7.0.1.jar -O /opt/spark/jars/azure-storage-7.0.1.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob/12.8.0/azure-storage-blob-12.8.0.jar -O /opt/spark/jars/azure-storage-blob-12.8.0.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob-nio/12.0.0-beta.12/azure-storage-blob-nio-12.0.0-beta.12.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/3.1.3/hadoop-azure-3.1.3.jar -O /opt/spark/jars/hadoop-azure-3.1.3.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.4.40.v20210413/jetty-util-9.4.40.v20210413.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util-ajax/9.4.40.v20210413/jetty-util-ajax-9.4.40.v20210413.jar
  EOT
}


resource "azurerm_storage_blob" "sequila" {
  name                   = "scripts/sequila-setup.sh"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  source_content         = local.pysequila_setup_file
}

resource "azurerm_storage_blob" "spark" {
  name                   = "scripts/spark-setup.sh"
  storage_account_name   = var.storage_account_name
  storage_container_name = var.storage_container_name
  type                   = "Block"
  source_content         = local.spark_setup_file
}

resource "random_string" "random-suffix" {
  length  = 8
  special = false
  upper   = false
  keepers = {
    sub_id = var.storage_container_id
  }
}

resource "azurerm_hdinsight_spark_cluster" "sequila" {
  name                = "sequila-${random_string.random-suffix.result}"
  resource_group_name = var.resource_group
  location            = var.region
  cluster_version     = var.hdinsight_version
  tier                = "Standard"

  component_version {
    spark = "3.1"
  }



  gateway {
    username = "sequila"
    password = var.gateway_password
  }

  storage_account {
    storage_container_id = var.storage_container_id
    storage_account_key  = var.storage_account_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Standard_A4_V2"
      username = "sequila"
      password = var.node_ssh_password
      script_actions {
        name       = "install-pysequila"
        uri        = azurerm_storage_blob.sequila.url
        parameters = null
      }
      script_actions {
        name       = "install-spark"
        uri        = azurerm_storage_blob.spark.url
        parameters = null
      }

    }

    worker_node {
      vm_size               = "Standard_A4_V2"
      username              = "sequila"
      password              = var.node_ssh_password
      target_instance_count = 1
      script_actions {
        name       = "install-pysequila"
        uri        = azurerm_storage_blob.sequila.url
        parameters = null
      }
      script_actions {
        name       = "install-spark"
        uri        = azurerm_storage_blob.spark.url
        parameters = null
      }
    }

    zookeeper_node {
      vm_size  = "Medium"
      username = "acctestusrvm"
      password = var.node_ssh_password
    }
  }
}