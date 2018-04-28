FROM openjdk:8-jdk

# install git, curl, openssh server, and remove host keys
RUN apt-get update && apt-get install -y git curl openssh-server && mkdir /var/run/sshd && rm -rf /var/lib/apt/lists/* && rm -rf /etc/ssh/ssh_host_*

# prepare home, user for jenkins
ENV JENKINS_HOME /var/jenkins_home

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group} \
    && useradd -d "$JENKINS_HOME" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

VOLUME /var/jenkins_home

# get docker client
RUN mkdir -p /tmp/download && \
 curl -L https://download.docker.com/linux/static/stable/x86_64/docker-18.03.1-ce.tgz | tar -xz -C /tmp/download && \
 rm -rf /tmp/download/docker/dockerd && \
 mv /tmp/download/docker/docker* /usr/local/bin/ && \
 rm -rf /tmp/download && \
 groupadd -g 999 docker && \
 usermod -aG docker jenkins

# expose ssh port
EXPOSE 22

# make sure host keys are regenerated before sshd starts
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
