AWS_CDK_VERSION = 1.127.0
IMAGE ?= ghcr.io/ethanbayliss/docker-aws-cdk
IMAGE_NAME ?= $(IMAGE):$(AWS_CDK_VERSION)
TAG = $(AWS_CDK_VERSION)

SHELL := /bin/bash


build:
	docker build --no-cache --tag $(IMAGE_NAME) .

test:
	docker run --rm -it $(IMAGE_NAME) cdk --version

shell:
	docker run --rm -it -v ~/.aws:/root/.aws -v $(shell pwd):/opt/app $(IMAGE_NAME) bash

commit:
	-git tag --delete $(TAG)
	-git tag --delete latest
	-git push --delete origin $(TAG)
	-git push --delete origin latest
	-git add Makefile Dockerfile README.md
	-git commit -m "$(TAG)"
	-git push
	git tag $(TAG) HEAD
	git tag latest HEAD
	git push origin latest
	git push origin $(TAG)

# https://github.com/settings/tokens -> put your container token in cr_token file
push:
	cat cr_token | docker login ghcr.io -u ethanbayliss --password-stdin
	docker tag $(IMAGE_NAME) $(IMAGE):latest
	docker push $(IMAGE_NAME)

update: commit push
