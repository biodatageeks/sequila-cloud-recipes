from pysequila import SequilaSession

sequila = SequilaSession.builder \
    .appName("SeQuiLa") \
    .getOrCreate()

sequila\
    .pileup(f"gs://tbd-tbd-devel-staging/data/NA12878.multichrom.md.bam",
            f"/mnt/spark/Homo_sapiens_assembly18_chr1_chrM.small.fasta", False) \
    .show(5)