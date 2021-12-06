FROM gcr.io/spark-operator/spark-operator:v1beta2-1.2.3-3.1.1
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
USER root
RUN apt-get --allow-releaseinfo-change update && apt-get install -y wget
RUN cd /opt && rm -rf spark && wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz && \
    tar zxvf spark-3.1.2-bin-hadoop3.2.tgz && mv spark-3.1.2-bin-hadoop3.2 spark
RUN mkdir -p  /opt/spark/.ivy2/ && chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.4/gcs-connector-hadoop3-2.2.4-shaded.jar && \
    wget https://repo1.maven.org/maven2/com/google/cloud/google-cloud-nio/0.120.0-alpha/google-cloud-nio-0.120.0-alpha-shaded.jar
USER 185
