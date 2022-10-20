#https://www.jenkins.io/doc/book/installing/docker/
#https://hub.docker.com/r/jenkins/jenkins

FROM jenkins/jenkins:lts-jdk11
USER root
RUN apt-get update && apt-get install -y lsb-release --no-install-recommends
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt-get update && apt-get install -y docker-ce-cli --no-install-recommends && rm -rf /var/lib/apt/lists/* 

USER jenkins
ARG BLUEOCEAN_VERSION=1.25.8
ARG DOCKERPIPELINE_VERSION=521.v1a_a_dd2073b_2e
RUN jenkins-plugin-cli --plugins "blueocean:${BLUEOCEAN_VERSION} docker-workflow:${DOCKERPIPELINE_VERSION}"