ARG BASE_IMAGE
FROM $BASE_IMAGE

USER root

RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/microsoft/azure/azure-storage/7.0.1/azure-storage-7.0.1.jar -O /opt/spark/jars/azure-storage-7.0.1.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob/12.8.0/azure-storage-blob-12.8.0.jar -O /opt/spark/jars/azure-storage-blob-12.8.0.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob-nio/12.0.0-beta.12/azure-storage-blob-nio-12.0.0-beta.12.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/3.1.3/hadoop-azure-3.1.3.jar -O /opt/spark/jars/hadoop-azure-3.1.3.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.4.40.v20210413/jetty-util-9.4.40.v20210413.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util-ajax/9.4.40.v20210413/jetty-util-ajax-9.4.40.v20210413.jar
RUN chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
USER 185