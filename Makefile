REGISTRY := gcr.io/solo-io-public
APP_NAME := gloo
DEPLOYER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/deployer
INSTALLER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/installer

# The version of Gloo Edge that will be installed by the deployer/installer
GLOO_VERSION := 1.15.14

# For simplicity, the deployer version matches the underlying Gloo Edge version
DEPLOYER_IMAGE_VERSION := $(GLOO_VERSION)

#----------------------------------------------------------------------------------
# Build
#----------------------------------------------------------------------------------

.PHONY: docker-build
docker-build: docker-build-installer docker-build-deployer

.PHONY: docker-build-installer
docker-build-installer:
	docker build \
		-t $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) \
		--build-arg GLOO_VERSION=$(GLOO_VERSION) \
		-f installer/Dockerfile \
		--platform linux/amd64 \
		installer

.PHONY: docker-build-deployer
docker-build-deployer:
	docker build \
		-t $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) \
		-f Dockerfile \
		. --no-cache

#----------------------------------------------------------------------------------
# Publish
#----------------------------------------------------------------------------------

.PHONY: publish
publish: docker-build docker-push

.PHONY: docker-push
docker-push: docker-push-installer docker-push-deployer

.PHONY: docker-push-deployer
docker-push-deployer:
	docker push $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

.PHONY: docker-push-installer
docker-push-installer:
	docker push $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)


#----------------------------------------------------------------------------------
# Test / Verify
#----------------------------------------------------------------------------------

.PHONY: mpdev-doctor
mpdev-doctor:
	REGISTRY=$(REGISTRY) mpdev doctor

.PHONY: mpdev-verify
mpdev-verify:
	mpdev /scripts/verify --deployer=gcr.io/solo-io-public/gloo/deployer:$(DEPLOYER_IMAGE_VERSION)

TEST_NS ?= test-ns-1-2

.PHONY: test-install
test-install:
	kubectl create namespace $(TEST_NS)

	mpdev /scripts/install \
  --deployer=$(REGISTRY)/$(APP_NAME)/deployer:$(DEPLOYER_IMAGE_VERSION) \
  --parameters='{"name": "test-install", "namespace": "$(TEST_NS)"}'

.PHONY: test-uninstall
test-uninstall:
	kubectl delete namespace $(TEST_NS)

.PHONY: patch-helm
patch-helm:
	./patch-helm.sh