from pysequila import SequilaSession
import subprocess

sequila = SequilaSession.builder \
    .appName("SeQuiLa") \
    .config("spark.driver.memory", "4g") \
    .getOrCreate()

staging_bucket = subprocess.getoutput("/usr/share/google/get_metadata_value attributes/dataproc-bucket")

sequila\
    .pileup(f"gs://{staging_bucket}/data/NA12878.multichrom.md.bam",
            f"/tmp/Homo_sapiens_assembly18_chr1_chrM.small.fasta", False) \
    .show(5)