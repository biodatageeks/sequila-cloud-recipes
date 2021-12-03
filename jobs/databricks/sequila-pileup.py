from pysequila import SequilaSession
import subprocess

sequila = SequilaSession.builder \
    .appName("SeQuiLa") \
    .config("spark.driver.memory", "4g") \
    .getOrCreate()

print(sequila.version)