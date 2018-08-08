FROM ubuntu:18.04

# MAINTAINER

# 2017.04.24
# glances montior test Docker file
# how to use?
#
# docker run TARGETNAME -P or -p port name to mapping host port
# the glance default port is 61208 , your can change it by using -p

RUN apt-get update ; apt-get upgrade -y ; apt-get install glances -y
CMD ["/usr/bin/glances","-w","-p 8080"]

EXPOSE 8080