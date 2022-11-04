FROM gcr.io/spark-operator/spark-operator:v1beta2-1.2.3-3.1.1
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
USER root
RUN apt-get --allow-releaseinfo-change update && apt-get install -y wget

RUN mkdir -p  /opt/spark/.ivy2/ && chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.4/hadoop-aws-2.7.4.jar
RUN chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
USER 185
