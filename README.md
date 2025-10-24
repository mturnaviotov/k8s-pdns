# PowerDNS customized setup for k8s

1. Tune image, if you need
2. Build it

```
docker buildx build -t pdns .
helm install -n pdns pdns ./charts/pdns
```

3. Push it to your repo
4. Tune helm chart, if you need, as example for change image location
5. Make and publish helm chart package to you helm repo
6. Use attached terraform helm release as reference

# TODO
1. Add more convinient code for correct initialization script, currently it hardcoded
2. Add more clear configuration