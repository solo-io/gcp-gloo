
REGISTRY := gcr.io/solo-io-public
APP_NAME := gloo
DEPLOYER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/deployer
INSTALLER_IMAGE_REPO := $(REGISTRY)/$(APP_NAME)/installer
DEPLOYER_IMAGE_VERSION := 1.2

.PHONY: docker-push
docker-push: docker-push-glooctl docker-push-deployer

.PHONY: docker-push-deployer
docker-push-deployer:
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

TEST_NS:=test-ns-1-2
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

# copy all the gloo images into the marketplace repo
.PHONY: docker-mirror
docker-mirror:
	go run scripts/sync_images/main.go


.PHONY: cleanup-cluster.
cleanup-cluster:
	kubectl delete namespace $(TEST_NS)
	kubectl delete clusterrolebinding gloo-resource-mutator-binding-$(TEST_NS)
	kubectl delete clusterrolebinding gloo-resource-reader-binding-$(TEST_NS)
	kubectl delete clusterrolebinding gloo-upstream-mutator-binding-$(TEST_NS)
	kubectl delete clusterrolebinding settings-user-binding-$(TEST_NS)
	kubectl delete clusterrolebinding gateway-resource-reader-binding-$(TEST_NS)
	kubectl delete clusterrolebinding kube-resource-watcher-binding-$(TEST_NS)
	kubectl delete clusterrole gateway-resource-reader-$(TEST_NS)
	kubectl delete clusterrole gloo-resource-mutator-$(TEST_NS)
	kubectl delete clusterrole gloo-resource-reader-$(TEST_NS)
	kubectl delete clusterrole gloo-upstream-mutator-$(TEST_NS)
	kubectl delete clusterrole kube-resource-watcher-$(TEST_NS)
	kubectl delete clusterrole settings-user-$(TEST_NS)
	kubectl delete clusterrole apiserver-ui-$(TEST_NS)
	kubectl delete clusterrole gloo-glooe-prometheus-alertmanager
	kubectl delete clusterrole gloo-glooe-prometheus-pushgateway
	kubectl delete clusterrole glooe-prometheus-kube-state-metrics
	kubectl delete clusterrole glooe-prometheus-server
	kubectl delete clusterrole observability-upstream-role-$(TEST_NS)
	kubectl delete clusterrolebinding apiserver-ui-role-binding-$(TEST_NS)
	kubectl delete clusterrolebinding gloo-glooe-prometheus-alertmanager
	kubectl delete clusterrolebinding gloo-glooe-prometheus-pushgateway
	kubectl delete clusterrolebinding glooe-prometheus-kube-state-metrics
	kubectl delete clusterrolebinding glooe-prometheus-server
	kubectl delete clusterrolebinding glooe-settings-user-role-binding-$(TEST_NS)
	kubectl delete clusterrolebinding observability-upstream-rolebinding-$(TEST_NS)
