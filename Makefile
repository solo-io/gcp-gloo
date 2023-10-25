
REGISTRY := gcr.io/solo-io-public
APP_NAME := gloo
DEPLOYER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/deployer
INSTALLER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/installer
DEPLOYER_IMAGE_VERSION := 1.4.0

# The version of Gloo Edge that will be installed by the deployer/installer
GLOO_VERSION := 1.15.14

.PHONY: docker-build
docker-build: docker-build-installer docker-build-deployer

.PHONY: docker-build-installer
docker-build-installer:
	docker build \
		-t $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) \
		--build-arg GLOO_VERSION=$(GLOO_VERSION) \
		-f installer/Dockerfile \
		installer

.PHONY: docker-build-deployer
docker-build-deployer:
	docker build \
		-t $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) \
		-f Dockerfile \
		. --no-cache

.PHONY: docker-push
docker-push: docker-push-installer docker-push-deployer

.PHONY: docker-push-deployer
docker-push-deployer:
	docker push $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

# glooctl installer
.PHONY: docker-push-installer
docker-push-installer:
	docker push $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

# Used to publish new versions
.PHONY: publish
publish: docker-build
publish: docker-push

.PHONY: mpdev-doctor
mpdev-doctor:
	REGISTRY=$(REGISTRY) mpdev doctor

TEST_NS ?= test-ns-1-2

.PHONY: test-install
test-install:
	kubectl create namespace $(TEST_NS)
# for now, do this to create the service accounts needed for the installer
#	helm template chart/glooctlinstaller/ --name test --namespace $(TEST_NS) --set rbac=true,marketplaceResources=false | kubectl apply -f -
# note that we can subsitute name and namespace only
# other values will be set from defaults during the below test command:
	mpdev /scripts/install \
  --deployer=$(REGISTRY)/$(APP_NAME)/deployer:$(DEPLOYER_IMAGE_VERSION) \
  --parameters='{"name": "test-install", "namespace": "$(TEST_NS)"}'

.PHONY: test-uninstall
test-uininstall:
	kubectl delete namespace $(TEST_NS)

.PHONY: mpdev-verify
mpdev-verify:
		mpdev /scripts/verify --deployer=gcr.io/solo-io-public/gloo/deployer:$(DEPLOYER_IMAGE_VERSION)
