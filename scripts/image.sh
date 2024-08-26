#!/bin/sh
set -x
VERSION=latest
IMAGE_NAME=l2discovery
REPO=quay.io/redhat-cne
make test
go build l2discovery.go
podman build -t ${IMAGE_NAME} --rm -f Dockerfile .
podman tag ${IMAGE_NAME} ${REPO}/${IMAGE_NAME}:${VERSION}
podman push ${REPO}/${IMAGE_NAME}:${VERSION}
