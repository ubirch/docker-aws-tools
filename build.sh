#!/bin/bash -x

if [ "${GO_PIPELINE_LABEL:-zero}" == "zero" ]; then
  GO_PIPELINE_LABEL=latest
fi

# build the docker container
function build_container() {



    echo "Building AWS Tools container"

    docker build --build-arg VCS_REF=`git rev-parse --short HEAD` --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` -t ubirch/aws-tools:${GO_PIPELINE_LABEL} -f Dockerfile .


    if [ $? -ne 0 ]; then
        echo "Docker build failed"
        exit 1
    fi

}

# publish the new docker container
function publish_container() {
  echo "Publishing Docker Container with version: ${GO_PIPELINE_LABEL}"
  docker tag ubirch/aws-tools ubirch/aws-tools:latest
  docker tag ubirch/aws-tools ubirch/aws-tools:v${GO_PIPELINE_LABEL}
  docker push ubirch/aws-tools:v${GO_PIPELINE_LABEL} && docker push ubirch/aws-tools

  if [ $? -ne 0 ]; then
    echo "Docker push faild"
    exit 1
  fi

}


case "$1" in
    build)
        build_container
        ;;
    publish)
        publish_container
        ;;
    *)
        echo "Usage: $0 {build|publish}"
        exit 1
esac

exit 0
