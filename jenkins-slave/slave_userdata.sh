#!/bin/bash
mkdir -p /var/jenkins_home/.ssh
cp /home/ggiacalone/.ssh/authorized_keys /var/jenkins_home/.ssh/authorized_keys
chmod 700 /var/jenkins_home/.ssh
chmod 600 /var/jenkins_home/.ssh/authorized_keys
chown -R ggiacalone:ggiacalone /var/jenkins_home
docker run -p 2222:22 -v /var/jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock --restart always -d dagman62/jenkins-slave
