VER := $(shell git log -n1 --format="%h")

.PHONY: help

default: package-docker

help:
	@cat  README.md

requirements:
	pip3 install -r requirements.txt

install: requirements

run: 
	python3 server.py



package: 
	@echo "Building docker image"	
	@docker build \
		--build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') \
		--build-arg VCS_REPO="$(git config --get remote.origin.url)" \
		--build-arg VCS_BRANCH="$(git branch --show-current)" \
		--build-arg VCS_REF=${VER} \
		--build-arg VCS_REF_FULL=$(git log -n1 --format="%H") \
		--build-arg VCS_COMMIT_LOG="$(git log -n1  --pretty='format:[%h] on at [%ci] by [%an<%ae>])" \
		-t yogendra/tmc-cluster-autoscaler:${VER} \
		-t yogendra/tmc-cluster-autoscaler:latest .

publish: package
	@echo "Publish"
	@docker push yogendra/tmc-cluster-autoscaler:latest	
	@docker push yogendra/tmc-cluster-autoscaler:${VER}

test: package
	docker run \
		--rm \
		-it \
		--name tmc-cas-test \
		-e TMC_API_TOKEN=${TMC_API_TOKEN} \
		yogendra/tmc-cluster-autoscaler:latest
