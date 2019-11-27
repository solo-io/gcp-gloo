
REGISTRY := gcr.io/solo-io-public
APP_NAME := gloo
DEPLOYER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/deployer
INSTALLER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/installer
TMPSUF := aa
DEPLOYER_IMAGE_VERSION := 1.1$(TMPSUF)

GLOO_VERSION := 1.0.0

.PHONY: docker-push
docker-push:
	REGISTRY=$(REGISTRY) APP_NAME=$(APP_NAME) docker build -t $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) -f Dockerfile . --no-cache
	docker push $(DEPLOYER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

# glooctl installer
.PHONY: docker-push-glooctl
docker-push-glooctl:
	docker build -t $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION) -f installer/Dockerfile installer
	docker push $(INSTALLER_IMAGE_REPO):$(DEPLOYER_IMAGE_VERSION)

.PHONY: mpdev-doctor
mpdev-doctor:
	REGISTRY=$(REGISTRY) mpdev doctor

# TEST_NS:=test-ns-$(DEPLOYER_IMAGE_VERSION)
TEST_NS:=test-ns-1$(TMPSUF)
.PHONY: test-install
test-install:
	kubectl create namespace $(TEST_NS)
# for now, do this to create the service accounts needed for the installer
	helm template chart/glooctlinstaller/ --name test --namespace $(TEST_NS) --set rbac=true,marketplacResources=false | kubectl apply -f -
	mpdev /scripts/install \
  --deployer=$(REGISTRY)/$(APP_NAME)/deployer:$(DEPLOYER_IMAGE_VERSION) \
  --parameters='{"name": "test-install", "namespace": "$(TEST_NS)", "enterpriseLicense": "psst", "glooctlinstaller.abc": "xyz"}'

# copy all the gloo images into the marketplace repo
.PHONY: docker-mirror
docker-mirror:
	go run scripts/sync_images/main.go
