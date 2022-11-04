FROM gcr.io/spark-operator/spark-operator:v1beta2-1.2.3-3.1.1
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
USER root
RUN apt-get --allow-releaseinfo-change update && apt-get install -y wget
RUN mkdir -p  /opt/spark/.ivy2/ && chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/microsoft/azure/azure-storage/7.0.1/azure-storage-7.0.1.jar -O /opt/spark/jars/azure-storage-7.0.1.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob/12.8.0/azure-storage-blob-12.8.0.jar -O /opt/spark/jars/azure-storage-blob-12.8.0.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob-nio/12.0.0-beta.9/azure-storage-blob-nio-12.0.0-beta.9.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/2.7.4/hadoop-azure-2.7.4.jar -O /opt/spark/jars/hadoop-azure-2.7.4.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.4.40.v20210413/jetty-util-9.4.40.v20210413.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util-ajax/9.4.40.v20210413/jetty-util-ajax-9.4.40.v20210413.jar
RUN chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
USER 185
