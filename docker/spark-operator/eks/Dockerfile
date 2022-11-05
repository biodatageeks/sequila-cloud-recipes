FROM gcr.io/spark-operator/spark-operator:v1beta2-1.2.3-3.1.1
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
ARG IVY_DIR=/opt/spark/.ivy2
ENV IVY_DIR=$IVY_DIR
ARG SPARK_VERSION=3.2.2
USER root
RUN apt-get --allow-releaseinfo-change update && apt-get install -y wget
RUN cd /opt && rm -rf spark && \
    wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.2.tgz && \
    tar zxvf spark-${SPARK_VERSION}-bin-hadoop3.2.tgz && mv spark-${SPARK_VERSION}-bin-hadoop3.2 spark
RUN mkdir -p $IVY_DIR && chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
ENV DEFAULT_SPARK_ARGS="--conf spark.jars.ivy=$IVY_DIR --packages org.apache.hadoop:hadoop-aws:3.3.1"
RUN echo :quit | ${SPARK_HOME}/bin/spark-shell --master local[1] $DEFAULT_SPARK_ARGS \
    && mv $IVY_DIR/jars/* $SPARK_HOME/jars \
    && rm -rf $IVY_DIR/jars/
RUN chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
USER 185
