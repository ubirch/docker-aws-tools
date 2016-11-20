FROM debian:jessie
MAINTAINER Falko Zurell <falko.zurell@ubirch.com>

LABEL description="uBirch aws tools container"
RUN apt-get update && apt-get install python-pip -y && \
    apt-get autoclean && apt-get --purge -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN pip install boto
RUN pip install awscli

WORKDIR /opt
VOLUME /build
WORKDIR /build
