DOCKER_VERSION := $(shell docker --version 2>/dev/null)
DOCKER_COMPOSE_VERSION := $(shell docker-compose --version 2>/dev/null)

ENV_BROWSER_HYDRA_HOST ?= localhost
ENV_BROWSER_CONSUMER_HOST ?= localhost
ENV_BROWSER_IDP_HOST ?= localhost

ENV_ECOSYSTEM_VERSION ?= v1.0.0-beta.9

all:
ifndef DOCKER_VERSION
    $(error "command docker is not available, please install Docker")
endif
ifndef DOCKER_COMPOSE_VERSION
    $(error "command docker-compose is not available, please install Docker")
endif

export LOGIN_CONSENT_VERSION=${ENV_ECOSYSTEM_VERSION}
export HYDRA_VERSION=${ENV_ECOSYSTEM_VERSION}

export BROWSER_HYDRA_HOST=${ENV_BROWSER_HYDRA_HOST}
export BROWSER_CONSUMER_HOST=${ENV_BROWSER_CONSUMER_HOST}
export BROWSER_IDP_HOST=${ENV_BROWSER_IDP_HOST}

build-dev:
		docker build -t oryd/hydra:dev ${GOPATH}/src/github.com/ory/hydra/

###

start-full-stack:
		cd full-stack; docker-compose up --build -d

restart-full-stack:
		cd full-stack; docker-compose restart

rm-full-stack:
		cd full-stack; docker-compose kill
		cd full-stack; docker-compose rm -f

reset-full-stack: rm-full-stack start-full-stack
