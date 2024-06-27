docker stop guardrails-server || true
docker rm guardrails-server || true
docker run -p 8000:8000 --name guardrails-server -it guardrails-server:dev