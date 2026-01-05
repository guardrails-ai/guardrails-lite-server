#!/bin/bash

docker buildx build \
    --platform linux/amd64 \
    -f Dockerfile \
    --build-arg="GUARDRAILS_TOKEN=$GUARDRAILS_TOKEN" \
    -t "guardrails-server:dev"  \
    --progress plain \
    --load . \
    || exit 1;