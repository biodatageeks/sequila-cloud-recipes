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
RUN mkdir -p $IVY_DIR

ENV DEFAULT_SPARK_ARGS="--conf spark.jars.ivy=$IVY_DIR --repositories $EXTRA_MVN_REPO --packages org.biodatageeks:sequila_2.12:$SEQUILA_VERSION"
RUN echo :quit | spark-shell --master local[1] $DEFAULT_SPARK_ARGS
ENV PYSPARK_SUBMIT_ARGS="${DEFAULT_SPARK_ARGS} pyspark-shell"
RUN chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
RUN rm -f $IVY_DIR/jars/io.netty_netty-*.jar $IVY_DIR/jars/org.apache.commons_commons-lang3-*.jar
USER 185