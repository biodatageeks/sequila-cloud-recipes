FROM gcr.io/spark-operator/spark-py:v3.1.1
ARG PYSEQUILA_VERSION
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
USER root
RUN pip install -U pysequila==$PYSEQUILA_VERSION --extra-index-url=https://zsibio.ii.pw.edu.pl/nexus/repository/bdg-pip/simple
RUN apt-get --allow-releaseinfo-change update && apt-get install -y wget
RUN cd /opt && rm -rf spark && wget https://dlcdn.apache.org/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz && \
    tar zxvf spark-3.1.2-bin-hadoop3.2.tgz && mv spark-3.1.2-bin-hadoop3.2 spark

RUN mkdir -p  /opt/spark/.ivy2/ && chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/

RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/com/microsoft/azure/azure-storage/7.0.1/azure-storage-7.0.1.jar -O /opt/spark/jars/azure-storage-7.0.1.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob/12.8.0/azure-storage-blob-12.8.0.jar -O /opt/spark/jars/azure-storage-blob-12.8.0.jar && \
    wget https://repo1.maven.org/maven2/com/azure/azure-storage-blob-nio/12.0.0-beta.12/azure-storage-blob-nio-12.0.0-beta.12.jar && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/3.1.3/hadoop-azure-3.1.3.jar -O /opt/spark/jars/hadoop-azure-3.1.3.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util/9.4.40.v20210413/jetty-util-9.4.40.v20210413.jar && \
    wget https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-util-ajax/9.4.40.v20210413/jetty-util-ajax-9.4.40.v20210413.jar
COPY sequila-assembly-0.7.5-no-hdfs-nio.jar /opt/spark/jars/
USER 185