from pysequila import SequilaSession
import time
sequila = SequilaSession.builder \
  .appName("SeQuiLa") \
  .getOrCreate()

sequila.sql("SET spark.biodatageeks.readAligment.method=disq")
sequila\
  .pileup(f"wasb://sequila@sequilauxlw3g9fznm.blob.core.windows.net/data/NA12878.multichrom.md.bam",
          f"/mnt/spark/Homo_sapiens_assembly18_chr1_chrM.small.fasta", False) \
  .show(5)
