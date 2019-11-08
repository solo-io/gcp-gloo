
REGISTRY := gcr.io/solo-io-public
APP_NAME := gloo
DEPLOYER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/deployer
DEPLOYER_IMAGE_VERSION := 0.1a

.PHONY: docker-push
docker-push:
	docker build -t $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) .
	docker push $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

.PHONY: mpdev-doctor
mpdev-doctor:
	REGISTRY=$(REGISTRY) mpdev doctor

.PHONY: test-install
test-install:
	kubectl create namespace test-ns
	mpdev /scripts/install \
  --deployer=$(REGISTRY)/$(APP_NAME)/deployer \
  --parameters='{"name": "test-deployment", "namespace": "test-ns"}'
