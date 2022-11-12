resource "azurerm_hdinsight_spark_cluster" "example" {
  name                = "sequila-hdicluster"
  resource_group_name = var.resource_group
  location            = var.region
  cluster_version     = var.hdinsight_version
  tier                = "Standard"

  component_version {
    spark = "3.1"
  }

  gateway {
    username = "acctestusrgw"
    password = "TerrAform123!"
  }

  storage_account {
    storage_container_id = var.storage_container_id
    storage_account_key  = var.storage_account_access_key
    is_default           = true
  }

  roles {
    head_node {
      vm_size  = "Standard_A3"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }

    worker_node {
      vm_size               = "Standard_A3"
      username              = "acctestusrvm"
      password              = "AccTestvdSC4daf986!"
      target_instance_count = 3
    }

    zookeeper_node {
      vm_size  = "Medium"
      username = "acctestusrvm"
      password = "AccTestvdSC4daf986!"
    }
  }
}