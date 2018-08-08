FROM ubuntu:latest

# MAINTAINER 

# 2017.04.24
# utorrent-server on docker
# how to use?
#
# docker run -d -p 8080 -p 6881 --name ut-server --restart=always \
# -v /localhost/volume:/ut/share &
#
# http://yourIP:8080/gui or docker export IP /gui
# login as admin and NO password , you can change it on GUI
#
# µTorrent Server
# Copyright © 2013 BitTorrent, Inc.
# All Rights Reserved.
# Client Information
# Product Version 3.3
# Source Revision 30470
# Build Date 2014-01-14 09:10:15 -0800
# UI Revision 30470
#
# Peer ID UT330B
# User-agent uTorrent/330B(30470)(server)
# UPnP external address: --------

RUN apt-get update;apt-get upgrade -y;\
    apt-get install openssl libssl-dev wget -y
RUN wget http://download.ap.bittorrent.com/track/beta/endpoint/utserver/os/linux-x64-debian-7-0
RUN tar zxf linux-x64-debian-7-0 ; mv /utorrent-server-alpha-v3_3 /ut ; mkdir /ut/share
WORKDIR /ut

CMD ["/ut/utserver"]

EXPOSE 8080 6881