.PHONY: install lock install-lock env build start

install:
	pip install -r requirements.txt

lock:
	pip freeze > requirements-lock.txt

install-lock:
	pip install -r requirements-lock.txt

env:
	python3 -m venv ./.venv

build: install-lock
	guardrails hub install hub://guardrails/regex_match --quiet

start:
	uvicorn guardrails_api.app:create_app --workers 3 --host 0.0.0.0 --port 8000 --timeout-keep-alive 20 --timeout-graceful-shutdown 60;
