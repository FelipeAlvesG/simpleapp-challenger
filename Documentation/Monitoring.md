## Foi utilizado o Helm e instalado o Grafana e Promotheus, utilizamos uma Dashboard ja existente propria para Kubernets de id 6417


### Para configurar a monitoração do seu cluster Kubernetes usando Prometheus e Grafana via Helm, você pode seguir estes passos:
1) Adicione o repositório do prometheus e grafana, depois atualize para ele reconhece-los: 
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
```

2) Criar um namespace para monitoração se quiser, mas se não quiser pule esta etapa e quando for subir o Prometheus e Grafana altere o namespace para default ou deixe vazio:
```bash
kubectl create namespace monitoring
```

3) Instalar o Prometheus usando o Helm:
```bash
helm install prometheus prometheus-community/kube-prometheus-stack --namespace monitoring
Obs: Aqui se instala o kube-prometheus-stack, que inclui o Prometheus, Alertmanager, e vários exporters para monitorar o cluster Kubernetes.
```

4) Instalar o Grafana usando o Helm:
```bash
helm install grafana grafana/grafana --namespace monitoring
```
Isso instala o Grafana no mesmo namespace de monitoração.


5) Obter a senha do Grafana:
```bash
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

6) Para acessar o Grafana, você pode expor o serviço usando um port-forward:
```bash
kubectl port-forward --namespace monitoring svc/grafana 3000:80
```

### Configurações no Grafana e Prometheus.
Você pode importar um dashboard pré-configurado. Aqui está um exemplo de um dashboard básico para Kubernetes:
Faça login no Grafana.
Vá até a seção "Dashboards" -> "Manage" -> "Import".
Insira o ID do dashboard público. Um dashboard popular para Kubernetes é o ID 3119 ou 6417.
Configure as fontes de dados conforme necessário e finalize a importação.

#### Conectando o prometheus e o grafana:

Para conectar o prometheus com o grafana, vá em `/connections/datasources/prometheus`, após isso clique no botão `Add new data source`, insira o endpoint/url do prometheus.
Para conseguir o endpoint através do kubectl basta:
```bash
kubectl get svc prometheus-server -o jsonpath='http://{.spec.clusterIP}:{.spec.ports[0].port}'
```

Se mesmo assim não mostrar nada voce deve entrar nas opções de fonte de dados e vê se o prometheus está conectado se tiver veja as configurações se na aba Connection está vazia, se tiver ou com algum erro voce pode colocar 

http://prometheus-kube-prometheus-prometheus:9090

Salve & Test

Pronto!