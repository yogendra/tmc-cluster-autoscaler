.PHONY: help

help:
	@cat  README.md

install:
	pip install --user -r requirements.txt

test: install
	python3 server.py

package: install
	@echo "Building docker image"
	@docker build --no-cache=true --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF=$(git log --format="%H" -n 1) -t yogendra/tmc-cluster-autoscaler:latest .

publish: install, package
	@echo "Publish"
	@docker push yogendra/tmc-cluster-autoscaler:latest	


