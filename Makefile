AWS_CDK_VERSION = 1.126.0
IMAGE_NAME ?= ghcr.io/ethanbayliss/docker-aws-cdk:$(AWS_CDK_VERSION)
TAG = $(AWS_CDK_VERSION)

SHELL := /bin/bash

build:
	docker build -t $(IMAGE_NAME) .

test:
	docker run --rm -it $(IMAGE_NAME) cdk --version

shell:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) bash

gitTag:
	-git tag -d $(TAG)
	-git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push origin $(TAG)

# https://github.com/settings/tokens -> put your container token in cr_token file
push:
	cat cr_token | docker login ghcr.io -u ethanbayliss --password-stdin
	docker push $(IMAGE_NAME)