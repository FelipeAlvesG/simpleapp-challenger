# Cluster kubernetes com KIND

Para criar o cluster Kubernetes utilizei o Kind, e para agilizar a criação criei um '.yaml' na raiz do projeto para subi-lo, com 1 Control Plane e 3 Works.

```
kind create cluster --config "kind-cluster.yaml" --name devops-test
```
Na tag --config passa o arquivo que foi criado para configurar o cluster e nao tag --name você define o nome para o Cluster.