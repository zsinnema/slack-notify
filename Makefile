
DOCKER_REGISTRY ?= "us.gcr.io/metacellllc/ifn/"
VERSION ?= 1.0.1

.PHONY: build
build:
	mkdir -p bin/
	go build -o bin/slack-notify ./main.go

.PHONY: docker-build
docker-build:
	mkdir -p rootfs
	GOOS=linux GOARCH=amd64 go build -o rootfs/slack-notify ./main.go
	docker build -t $(DOCKER_REGISTRY)/ifn-stats:${VERSION} .

.PHONY: docker-push
docker-push:
	docker push $(DOCKER_REGISTRY)/ifn-stats:${VERSION}

.PHONY: bootstrap
bootstrap:


