FROM ubuntu:latest

# MAINTAINER

# 2017.05.01
# squid on docker
# how to use?
# 
# docker run -d -p 3128:3128 CONTAINER-NAME
# you can copy squid.conf from CONTAINER , docker cp CONTAINER:/etc/squid/squid.conf ~
# and modify it than copy it to new CONTAINER

RUN apt-get update ; apt-get upgrade -y ; apt-get install squid -y
RUN rm /etc/squid/squid.conf
COPY ./squid.conf /etc/squid/

# -N means run squid at no Deamon mode!!
CMD ["/usr/sbin/squid","-N"]

EXPOSE 3128