#!/bin/bash

docker buildx build \
    --platform linux/amd64 \
    -f Dockerfile \
    -t "guardrails-server:dev"  \
    --progress plain \
    --load . \
    || exit 1;