FROM    ubuntu:20.04
#checkov:skip=CKV_DOCKER_2: "Ensure that HEALTHCHECK instructions have been added to container images"
#checkov:skip=CKV_DOCKER_3: "Ensure that a user for the container has been created"
ARG JAVA_VERSION=11.0.11.hs-adpt
ARG SCALA_VERSION=2.12.13
ARG SBT_VERSION=1.3.10
ARG SPARK_OPERATOR_VERSION=1.1.11
ARG K9S_VERSION=0.26.7
ARG SEQ_VERSION
ENV JAVA_VERSION=$JAVA_VERSION \
    SCALA_VERSION=$SCALA_VERSION \
    SBT_VERSION=$SBT_VERSION \
    SEQ_VERSION=$SEQ_VERSION


ENV TZ=Europe/Warsaw

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone && \
    apt -y update && \
    apt -y upgrade && \
    apt install -y curl gnupg lsb-release software-properties-common apt-transport-https ca-certificates git pwgen

RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add - && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" && \
    apt install -y terraform

RUN curl https://baltocdn.com/helm/signing.asc | apt-key add - && \
    echo "deb https://baltocdn.com/helm/stable/debian/ all main" |  tee /etc/apt/sources.list.d/helm-stable-debian.list && \
    apt -y update && \
    apt install -y helm

RUN  curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" |  tee /etc/apt/sources.list.d/kubernetes.list && \
    apt -y update && \
    apt install -y kubectl

RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" |  tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key --keyring /usr/share/keyrings/cloud.google.gpg add - && \
    apt -y update && \
    apt install -y google-cloud-sdk google-cloud-sdk-gke-gcloud-auth-plugin

RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
    gpg --dearmor | \
    tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get -y update && apt-get install -y azure-cli

RUN apt install -y wget jq vim
RUN mkdir -p /opt/tools && \
    cd /opt/ && wget https://github.com/derailed/k9s/releases/download/v${K9S_VERSION}/k9s_Linux_x86_64.tar.gz -O /opt/k9s_Linux_x86_64.tar.gz && \
    tar zxvf k9s_Linux_x86_64.tar.gz -C /opt/tools

ENV PATH=$PATH:/opt/tools

RUN wget https://golang.org/dl/go1.16.2.linux-amd64.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf go1.16.2.linux-amd64.tar.gz

ENV PATH=$PATH:/usr/local/go/bin
WORKDIR /home/git
RUN git clone https://github.com/GoogleCloudPlatform/spark-on-k8s-operator.git && \
    cd spark-on-k8s-operator/sparkctl && \
    git checkout tags/spark-operator-chart-${SPARK_OPERATOR_VERSION} && \
    go build -o sparkctl

ENV PATH=$PATH:/home/git/spark-on-k8s-operator/sparkctl

ENV HOME_DIR=/home
ENV SECRETS_DIR=$HOME_DIR/sequila/secrets

RUN mkdir -p $SECRETS_DIR
WORKDIR $HOME_DIR

SHELL ["/bin/bash", "-c"]

RUN apt install unzip zip && \
    curl -s https://get.sdkman.io | bash
RUN chmod a+x "$HOME/.sdkman/bin/sdkman-init.sh"
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install java ${JAVA_VERSION}
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install scala ${SCALA_VERSION}
RUN source "$HOME/.sdkman/bin/sdkman-init.sh" && sdk install sbt ${SBT_VERSION}

COPY ../resources/bin/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

EXPOSE 3000 9090 9091
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]