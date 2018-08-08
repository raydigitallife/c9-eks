
#Let's Encrypt docker file , unfinished

FROM ubuntu:latest

RUN apt-get update ; apt-get upgrade -y ; apt-get install software-properties-common -y
RUN add-apt-repository ppa:certbot/certbot
RUN apt-get update ; apt-get install certbot ntpdate -y

EXPOSE 443

CMD ["/bin/bash"]
