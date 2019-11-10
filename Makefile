
REGISTRY := gcr.io/solo-io-public
APP_NAME := gloo
DEPLOYER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/deployer
DEPLOYER_IMAGE_VERSION := 1.0

GLOO_VERSION := 0.21.0

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
  --deployer=$(REGISTRY)/$(APP_NAME)/deployer:0.1 \
  --parameters='{"name": "test-deployment", "namespace": "test-ns"}'

# copy all the gloo images into the marketplace repo
.PHONY: docker-mirror
docker-mirror:
	go run scripts/sync_images/main.go
