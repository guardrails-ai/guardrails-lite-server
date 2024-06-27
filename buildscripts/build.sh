#!/bin/bash

docker build \
    -f Dockerfile \
    -t "guardrails-server:dev" .;