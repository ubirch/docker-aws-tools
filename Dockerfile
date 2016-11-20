FROM debian:jessie
MAINTAINER Falko Zurell <falko.zurell@ubirch.com>

# Build-time metadata as defined at http://label-schema.org
  ARG BUILD_DATE
  ARG VCS_REF
  LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.docker.dockerfile="/Dockerfile" \
        org.label-schema.license="e.g. MIT" \
        org.label-schema.name="ubirch AWS Tools Container" \
        org.label-schema.url="e.g. https://ubirch.com" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-type="Git" \
        org.label-schema.vcs-url="https://github.com/ubirch/docker-aws-tools"

LABEL description="uBirch aws tools container"
RUN apt-get update
RUN apt-get install python-pip -y
RUN pip install boto
RUN pip install boto3
RUN pip install awscli

ADD scripts /opt/scripts
WORKDIR /opt
VOLUME /build
WORKDIR /build
