# Deploy da aplicação

Antes do deploy da aplicação, vamos criar um "configmap" que será um manifesto que guardará variáveis de ambiente da aplicação de onde foi pego lá na primeira etapa do desafio.
```
kubectl apply -f manifest-app/simpleapp-cm.yaml
```
Após configurado as variáveis de ambientes, aplicaremos o restantes dos manifestos, sendo eles um `deployment` e um `service`.

```
kubectl apply -f manifest-app/simpleapp.yaml
kubectl apply -f manifest-app/serviceapp.yaml
```
Você também tem a opção de executar os 3 yaml de uma só vez com o comando, usando o ponto se estiver dentro da pasta dos manifestos:
```
kubectl apply -f .
```

Agora é só fazer um "port-forward" para poder acessar a aplicação com o comando:
```
kubectl port-forward svc/simpleapp-svc 8008:80
```

Pronto, acesse `http://localhost:8008/code` e veja se está tudo funcionando.