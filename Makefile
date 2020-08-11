GIT_VER := $(shell git log -n1 --format="%h")
VERSION := 1.0.0

.PHONY: help

default: package-docker

help:
	@cat  README.md

clean:
	@docker rmi -f \
	yogendra/tmc-cluster-autoscaler:latest-snapshot \
	yogendra/tmc-cluster-autoscaler:latest \
	yogendra/tmc-cluster-autoscaler:${VERSION} \
	yogendra/tmc-cluster-autoscaler:${GIT_VER}

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
		--build-arg VCS_REF=${GIT_VER} \
		--build-arg VCS_REF_FULL=$(git log -n1 --format="%H") \
		--build-arg VCS_COMMIT_LOG="$(git log -n1  --pretty='format:[%h] on at [%ci] by [%an<%ae>])" \
		-t yogendra/tmc-cluster-autoscaler:${GIT_VER} \
		-t yogendra/tmc-cluster-autoscaler:latest-snapshot .

push: package
	@echo "Publish"
	@docker push yogendra/tmc-cluster-autoscaler:latest-snapshot	
	@docker push yogendra/tmc-cluster-autoscaler:${GIT_VER}

publish: package push
	echo "Publish version"
	@docker tag yogendra/tmc-cluster-autoscaler:latest-snapshot yogendra/tmc-cluster-autoscaler:latest
	@docker tag yogendra/tmc-cluster-autoscaler:latest-snapshot yogendra/tmc-cluster-autoscaler:${VERSION}
	@docker push yogendra/tmc-cluster-autoscaler:latest
	@docker push yogendra/tmc-cluster-autoscaler:${VERSION}

test: package
	@echo "Running container"
	@docker run \
		--rm \
		-it \
		--name tmc-cas-test \
		-e TMC_API_TOKEN=${TMC_API_TOKEN} \
		-p 5000:5000 \
		yogendra/tmc-cluster-autoscaler:latest-snapshot
