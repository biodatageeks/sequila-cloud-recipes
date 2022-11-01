ARG BASE_IMAGE
FROM $BASE_IMAGE

ARG SEQUILA_VERSION
ARG PYSEQUILA_VERSION
ARG SPARK_VERSION
ARG EXTRA_PIP_INDEX
ARG EXTRA_MVN_REPO
ARG IVY_DIR=/opt/spark/.ivy2
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
USER root
RUN pip install -U pysequila==$PYSEQUILA_VERSION --extra-index-url=${EXTRA_PIP_INDEX}
RUN apt-get --allow-releaseinfo-change update && apt-get install -y wget
RUN mkdir -p $IVY_DIR && chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/

RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.4/gcs-connector-hadoop3-2.2.4-shaded.jar && \
    wget https://repo1.maven.org/maven2/com/google/cloud/google-cloud-nio/0.120.0-alpha/google-cloud-nio-0.120.0-alpha-shaded.jar

ARG DEFAULT_SPARK_ARGS="--conf spark.jars.ivy=$IVY_DIR --repositories $EXTRA_MVN_REPO --packages org.biodatageeks:sequila_2.12:$SEQUILA_VERSION"
RUN echo :quit | spark-shell --master local[1] $DEFAULT_SPARK_ARGS
ENV PYSPARK_SUBMIT_ARGS='${DEFAULT_SPARK_ARGS} pyspark-shell'
USER 185