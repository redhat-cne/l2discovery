#!/bin/sh
set -x
VERSION=multi
IMAGE_NAME=l2discovery
REPO=quay.io/redhat-cne
make test
go install github.com/karalabe/xgo@latest
xgo --targets=linux/arm64,linux/amd64 .
podman manifest create ${REPO}/${IMAGE_NAME}:${VERSION}
podman build --platform linux/amd64,linux/arm64  --manifest ${REPO}/${IMAGE_NAME}:${VERSION} --rm -f Dockerfile  .
podman manifest push ${REPO}/${IMAGE_NAME}:${VERSION}
