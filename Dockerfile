# ARG ALPINE_VERSION=3.13
ARG AWS_CDK_VERSION=1.105.0
# FROM alpine:${ALPINE_VERSION}
FROM amazon/aws-cli:latest

RUN yum update && \ 
	yum upgrade -y && \
	yum install -y \
	snapd \
	aufs-tools \
	automake \
	build-essential \
	nodejs \
	npm \
	python3 \
	ca-certificates \
	groff \
	less \
	bash \
	make \
	curl \
	wget \
	zip \
	git && \
	update-ca-trust force-enable && \
	# npm install -g aws-cdk@${AWS_CDK_VERSION} && \
	yum clean all

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]

# Allow for caching python modules
VOLUME ["/usr/lib/python3.8/site-packages/"]

WORKDIR /opt/app

# CMD ["cdk", "--version"]
