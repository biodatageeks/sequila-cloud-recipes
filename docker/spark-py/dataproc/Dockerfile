ARG BASE_IMAGE
FROM $BASE_IMAGE

USER root
ARG spark_uid=1099
RUN groupadd -g $spark_uid spark
RUN useradd -u $spark_uid -g $spark_uid -d /home/spark -m spark

ENV SPARK_EXTRA_CLASSPATH=$IVY_DIR/jars/*
RUN chown -R $spark_uid:$spark_uid $SPARK_EXTRA_CLASSPATH
ENV PYSPARK_PYTHON=/usr/bin/python3.9
RUN unset SPARK_HOME
USER spark