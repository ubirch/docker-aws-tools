#!/bin/bash -x


CONTAINER_NAME="ubirch/aws-tools"

if [ "${GO_PIPELINE_LABEL:-zero}" == "zero" ]; then
  GO_PIPELINE_LABEL="latest"
fi

# build the docker container
function build_container() {



    echo "Building AWS Tools container in ${PWD}"

    docker build --build-arg VCS_REF=`git rev-parse --short HEAD` \
    --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
    -t ${CONTAINER_NAME}:v${GO_PIPELINE_LABEL} -f Dockerfile .


    if [ $? -ne 0 ]; then
        echo "Docker build failed"
        exit 1
    else
        docker tag ${CONTAINER_NAME}:v${GO_PIPELINE_LABEL} ${CONTAINER_NAME}:latest
    fi

}

# publish the new docker container
function publish_container() {
  echo "Publishing Docker Container ${CONTAINER_NAME} with version: ${GO_PIPELINE_LABEL}"
  docker push ${CONTAINER_NAME}:v${GO_PIPELINE_LABEL} && docker push ${CONTAINER_NAME}

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
