FROM gcr.io/spark-operator/spark-py:v3.1.1
ARG PYSEQUILA_VERSION
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
USER root
RUN pip install -U pysequila==$PYSEQUILA_VERSION

USER 185