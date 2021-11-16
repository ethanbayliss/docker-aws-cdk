ARG AWS_CDK_VERSION=1.132.0
FROM node:14-bullseye

RUN apt-get update -y && \
	apt-get upgrade -y && \
	apt-get install -y snapd automake build-essential python3 python3-pip ca-certificates groff less bash make curl wget zip git && \
	update-ca-certificates && \
	python3 -m pip install awscli && \
	npm install -g aws-cdk@${AWS_CDK_VERSION}

VOLUME [ "/root/.aws" ]

# Allow for caching python modules
VOLUME ["/usr/lib/python3.8/site-packages/"]

WORKDIR /opt/app

#CMD ["cdk", "--version"]
CMD ["/bin/bash"]