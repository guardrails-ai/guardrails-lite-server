# Start our builder image in the multi-stage build
FROM public.ecr.aws/docker/library/python:3.13-slim AS builder

# Accept a build arg for the Guardrails token
# We'll add this to the config using the configure command below
ARG GUARDRAILS_TOKEN

# Set environment variables to avoid writing .pyc files and to unbuffer Python output
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Create app directory
WORKDIR /app

# Use a virtual environment
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy the requirements file
COPY requirements*.txt .

# Install app dependencies
# If you use Poetry this step might be different
RUN /opt/venv/bin/pip install -r requirements-lock.txt

# Run the Guardrails configure command to create a .guardrailsrc file
RUN guardrails configure --enable-metrics --enable-remote-inferencing  --token $GUARDRAILS_TOKEN

# Install any validators from the hub you want
RUN guardrails hub install hub://guardrails/regex_match


# Start our final image that we'll use
FROM public.ecr.aws/docker/library/python:3.13-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV LOGLEVEL="DEBUG"
ENV GUARDRAILS_LOG_LEVEL="DEBUG"

WORKDIR /app

COPY --from=builder /opt/venv /opt/venv

ENV PATH="/opt/venv/bin:$PATH"

# Copy the config over
COPY ./config.py ./config.py

EXPOSE 8000

# This is our start command; yours might be different.
# The guardrails-api is a standard FastAPI application.
# You can use whatever production server you want that supports it.
# Here we use uvicorn
CMD uvicorn guardrails_api.app:create_app --workers 3 --host 0.0.0.0 --port 8000 --timeout-keep-alive 20 --timeout-graceful-shutdown 60;