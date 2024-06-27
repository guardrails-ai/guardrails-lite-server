# guardrails-lite-server
A bare minimum deployment of guardrails as a service.


For this deployment, we use a config file to define our Guards so we don't need a database.

## Run the server locally

### Linux and MacOS
1. Clone this repository
2. `make env`
3. `source ./.venv/bin/activate`
4. `make build`
5. `make start`

Once the server is up and running, you can check out the Swagger docs at http://localhost:8000/docs


## Productionizing
We include a Dockerfile that shows the basic steps of containerizing this server.

We also include two bash scripts in the `buildscripts` directory that shows the basics of building the image and running it.