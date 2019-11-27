
REGISTRY := gcr.io/solo-io-public
APP_NAME := gloo
DEPLOYER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/deployer
INSTALLER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/installer
DEPLOYER_IMAGE_VERSION := 1.1e

GLOO_VERSION := 1.0.0

.PHONY: docker-push
docker-push:
	docker build -t $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) -f Dockerfile .
	docker push $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

# glooctl installer
.PHONY: docker-push-glooctl
docker-push-glooctl:
	docker build -t $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) -f installer/Dockerfile installer
	docker push $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

.PHONY: mpdev-doctor
mpdev-doctor:
	REGISTRY=$(REGISTRY) mpdev doctor

.PHONY: test-install
test-install:
	kubectl create namespace test-1e
	mpdev /scripts/install \
  --deployer=$(REGISTRY)/$(APP_NAME)/deployer:$(DEPLOYER_IMAGE_VERSION) \
  --parameters='{"name": "test-install", "namespace": "test-1e"}'

# copy all the gloo images into the marketplace repo
.PHONY: docker-mirror
docker-mirror:
	go run scripts/sync_images/main.go
