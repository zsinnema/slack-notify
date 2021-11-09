
DOCKER_REGISTRY ?= "us.gcr.io/metacellllc/ifn"
VERSION ?= 1.0.13

.PHONY: build
build:
	docker build -t $(DOCKER_REGISTRY)/ifn-stats:${VERSION} .

.PHONY: push
push:
	docker push $(DOCKER_REGISTRY)/ifn-stats:${VERSION}

.PHONY: deploy
deploy:
	$(shell sed -e s/{VERSION}/$(VERSION)/g ifnstatsnotify-tpl.yaml > deploy.yaml)
	kubectl -n ifn delete cronjob ifn-stats
	kubectl -n ifn apply -f deploy.yaml
	rm -f deploy.yaml

.PHONY: bootstrap
bootstrap:


