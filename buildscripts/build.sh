#!/bin/bash

docker build \
    -f Dockerfile \
    --build-arg="GUARDRAILS_TOKEN=$GUARDRAILS_TOKEN" \
    -t "guardrails-server:dev" .;