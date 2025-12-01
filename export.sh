docker container stop guardrails-server || true
docker container rm guardrails-server || true
docker container create --name guardrails-server guardrails-server:dev
docker container export guardrails-server > ./guardrails-server.tar