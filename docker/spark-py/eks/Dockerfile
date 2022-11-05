ARG BASE_IMAGE
FROM $BASE_IMAGE

USER root
RUN cd /opt/spark/jars && \
    wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/3.2.1/hadoop-aws-3.2.1.jar && \
    wget https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk-bundle/1.11.375/aws-java-sdk-bundle-1.11.375.jar && \
    wget https://repo1.maven.org/maven2/org/wildfly/openssl/wildfly-openssl/1.0.7.Final/wildfly-openssl-1.0.7.Final.jar
RUN chown -R 185 /opt/spark/ && chmod 777 -R /opt/spark/
USER 185