resource "azurerm_storage_blob" "sequila" {
  for_each               = toset(var.data_files)
  name                   = "data/${each.value}"
  storage_account_name   = var.storage_account
  storage_container_name = var.storage_container
  type                   = "Block"
  source                 = "data/${each.value}"
}


locals {
  py_file = <<-EOT
  from pysequila import SequilaSession
  import time
  sequila = SequilaSession.builder \
    .appName("SeQuiLa") \
    .getOrCreate()

  sequila.sql("SET spark.biodatageeks.readAligment.method=disq")
  sequila\
    .pileup(f"wasb://sequila@${var.storage_account}.blob.core.windows.net/data/NA12878.multichrom.md.bam",
            f"/mnt/spark/Homo_sapiens_assembly18_chr1_chrM.small.fasta", False) \
    .show(5)
  EOT
}



resource "local_file" "foo" {
  content  = local.py_file
  filename = "jobs/azure/aks/sequila-pileup.py"
}


resource "azurerm_storage_blob" "sequila-pileup" {
  name                   = "jobs/pysequila/sequila-pileup-aks.py"
  storage_account_name   = var.storage_account
  storage_container_name = var.storage_container
  type                   = "Block"
  source                 = "jobs/azure/aks/sequila-pileup.py"

}
