kubectl apply -f deployapp.yaml
kubectl apply -f configmap.yaml
kubectl expose deployment hello-server --type LoadBalancer --port 80 --target-port 8000
kubectl run redis --image=redis
kubectl expose pod redis --name=mvc --port=6379
kubectl get svc
