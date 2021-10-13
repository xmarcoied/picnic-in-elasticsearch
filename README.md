# picnic-in-elasticsearch

In this demo, I am trying to deploy a 3 nodes Elasticsearch (7.8.1) cluster that is suitable for local through minikube, or public cloud.
And, it's tested on mini_kube setup explained in the demo, and a 3-nodes standard GKE cluster.

## Walkthrough

The simplest method of deploying a standard elasticsearch is through helm, therefore first steps would be adding elasticsearch repo, charts

```bash
helm repo add elastic https://helm.elastic.co
```

As we want to first test the setup on local machine, we'll setup a [Minikue multi-node cluster](https://minikube.sigs.k8s.io/docs/tutorials/multi_node/)

```bash
minikube start --nodes 2 -p minikube
```

In order to properly support the required persistent volume claims for the
Elasticsearch StatefulSet, the `default-storageclass` and `storage-provisioner`
minikube addons must be enabled.

```bash
minikube addons enable default-storageclass
minikube addons enable storage-provisioner
```

For installing the elasticsearch chart, we are going to aid custom values to makesure high availability is applied, but still applicable for small-sized local-machine through nodeAffinity setup `antiAffinity: "soft"`

## Usage

* Setup multi-node minikube cluster: `make setup_minikube`

* Add helm-chart: `make add_helm`

* Deploy Elasticsearch chart: `make install`

* Test Elasticsearch chat: `make test`

* Try Elasticsearch API:

  ```bash
  kubectl port-forward svc/elasticsearch-master 9200
  curl localhost:9200/_cat/indices
  ```
