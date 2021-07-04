# Spinnaker Vagrant

Spin up a local debian spinnaker setup in local

## Run

- To setup kubernetes provider for spinnaker as part of spinnaker setup, copy kubernetes config file to an existing cluster to `tmp/kube.config`
  - A convenient script `export-kube-config.sh` is provided to export `minikube` setting from your host machine kubernetes config to `tmp/kube.config`
- Run

```
vagrant up
```

```
- Spinnaker UI (Deck) is accessiblae at [http://192.168.205.10:9000](http://192.168.205.10:9000)
- Spinnaker API Gateway (gate) is accessiblae at [http://192.168.205.10:8084](http://192.168.205.10:8084)
- MinIO UI is accessiable at [http://192.168.205.10:9001](http://192.168.205.10:9001)
```
