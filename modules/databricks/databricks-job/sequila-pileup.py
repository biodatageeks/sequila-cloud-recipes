from pysequila import SequilaSession

sequila = SequilaSession.builder \
    .appName("SeQuiLa") \
    .config("spark.driver.memory", "4g") \
    .getOrCreate()

display(sequila.version)
