.PHONY: help

default: package
help:
	@cat  README.md

requirements:
	pip install -r requirements.txt

install: requirements
	
test: install
	python3 server.py

package:
	@echo "Building docker image"
	@docker build --no-cache=true --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VCS_REF=$(git log --format="%H" -n 1) -t yogendra/tmc-cluster-autoscaler:latest .

publish: package
	@echo "Publish"
	@docker push yogendra/tmc-cluster-autoscaler:latest	

run: 
	python3 server.py
