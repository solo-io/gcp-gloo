
REGISTRY := gcr.io/solo-io-public
DEPLOYER_IMAGE_REPO := $(REGISTRY)/gloo/deployer
DEPLOYER_IMAGE_VERSION := 0.1

.PHONY: docker-push
docker-push:
	docker build -t $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) .
	docker push $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

.PHONY: mpdev-doctor
mpdev-doctor:
	REGISTRY=$(REGISTRY) mpdev doctor
