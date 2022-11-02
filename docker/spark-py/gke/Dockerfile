ARG BASE_IMAGE
FROM $BASE_IMAGE

USER root
RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/google/cloud/bigdataoss/gcs-connector/hadoop3-2.2.4/gcs-connector-hadoop3-2.2.4-shaded.jar && \
    wget https://repo1.maven.org/maven2/com/google/cloud/google-cloud-nio/0.120.0-alpha/google-cloud-nio-0.120.0-alpha-shaded.jar
RUN chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
USER 185