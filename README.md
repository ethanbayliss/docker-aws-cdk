# Docker AWS CDK
Containerised AWS CDK to ensure consistent local development and simple CD pipelines.

## Usage
Run as a command using `cdk` as entrypoint:

    docker run --rm --entrypoint cdk ghcr.io/ethanbayliss/docker-aws-cdk:latest --version

Run as a shell and mount `.aws` folder and current directory as volumes:

    docker run --rm -it -v ~/.aws:/root/.aws -v $(pwd):/opt/app ghcr.io/ethanbayliss/docker-aws-cdk:latest bash

Using docker-compose:

    cdk:
        image: ghcr.io/ethanbayliss/docker-aws-cdk:latest
        env_file: .env
        entrypoint: aws
        working_dir: /opt/app
        volumes:
        - ~/.aws:/root/.aws

And run `docker-compose run cdk --version`

## Language Support

CDK Supports different languages to define your (re)usable assets.

### JavaScrip/TypeScript

This should work out of the box through `package.json` and `node_modules`, which
are automatically _cached_ in your working directory.

### Python

This image ships with Python 3 installed. To cache installed cdk python packages,
`site-packages` is exposed as a volume. This allows you to cache packages between
invocations:

    cdk:
        ...
        volumes:
        - cdk-python:/usr/lib/python3.7/site-packages/
        - ...
    volumes:
        cdk-python

Then, if you install e.g. `aws-cdk.core` through pip (`pip3 install aws-cdk.core`)
in a container, you won't have to install it again next time you start a new
container.

### Java

> Not supported in this image yet

## Build 
Update the `AWS_CDK_VERSION` in both `Makefile` and `Dockerfile`. The run:

    make build

## Updates

To update this container with a newer version of the AWS CDK:

1. Update the Dockerfile with the new AWS CDK version number
2. Update the Makefile with the new AWS CDK version number
3. Submit pull request and get approved
4. (Ethan) make build && make test && make update

## Related Projects

- [docker-aws-cli](https://github.com/contino/docker-aws-cli)
- [docker-terraform](https://github.com/contino/docker-terraform)
