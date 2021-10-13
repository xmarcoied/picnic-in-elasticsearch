default: test

RELEASE := picnic-in-elasticsearch
TIMEOUT := 1200s

setup_minikube:
	minikube start --nodes 2 -p minikube
	minikube addons enable default-storageclass
	minikube addons enable storage-provisioner

add_helm:
	helm repo add elastic https://helm.elastic.co

install:
	helm upgrade --wait --timeout=$(TIMEOUT) --install --values values.yaml $(RELEASE) helm-charts/elasticsearch/

test: install
	helm test $(RELEASE)

purge:
	helm del $(RELEASE)
