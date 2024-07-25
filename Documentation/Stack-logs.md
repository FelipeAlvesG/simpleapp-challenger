## Configurando uma stack de logs
Para isso, vamos usar a combinação de Fluentd (ou Fluent Bit), Elasticsearch e Kibana, uma stack comum conhecida como EFK.

Como vamos usar o HELM, vamos atualizar o repositorio com as ferramentas antes de instalarmos.
```bash
helm repo add elastic https://helm.elastic.co
helm repo add fluent https://fluent.github.io/helm-charts
helm repo update
```

#### Instalando o Elastic-Search
```bash
helm install elasticsearch elastic/elasticsearch --namespace monitoring
```
#### Instalando o Kibana
```bash
helm install kibana elastic/kibana --namespace monitoring
```

#### Instalando o FluentD
Lebrando que o fluentD  só vai conseguir coletar os logs se tiver com o sidecar no deployment da aplicação.
Criamos um fluentd-values com as configs necessarias para enviar os logs para o Elasticserach.

Para instalar só executar o comando:

```bash
helm install fluentd fluent/fluentd --namespace monitoring -f fluentd-values.yaml
```
### Acessar o Kibana
Para acessar o Kibana, você pode expor o serviço usando um port-forward:
```bash
kubectl port-forward -n monitoring svc/kibana-kibana 5601:5601
```
Para pegar a senha do kibana temos que executar:
```bash
kubectl get secret --namespace monitoring elasticsearch-master-credentials -o jsonpath="{.data.password}" | base64 --decode; echo
```
Acesse o Kibana no navegador através do endereço http://localhost:5601.
Entre com Usuario elastic e senha que vc decodificou acima.

Para verificar os Logs no Kibana, você tem que configurar um padrão de índice para visualizar os logs. Vá até "Management" -> "Index Patterns" e crie um novo padrão com fluentd-* .

Depois de configurar o padrão de índice, você pode usar a seção "Discover" no Kibana para visualizar e consultar os logs da aplicação.

Seguindo esses passos, você terá uma stack de logs configurada e poderá visualizar os logs da sua aplicação no Kibana. Se precisar de mais ajuda em qualquer etapa, sinta-se à vontade para perguntar!




