
arwa@privatevm-tf:~$ kubectl apply -f deployapp.yaml
arwa@privatevm-tf:~$ kubectl apply -f configmap.yaml

arwaahmedmahmoud99@privatevm-tf:~$ kubectl expose deployment hello-server --type LoadBalancer --port 80 --target-port 8000
arwaahmedmahmoud99@privatevm-tf:~$ kubectl run redis --image=redis
arwaahmedmahmoud99@privatevm-tf:~$ kubectl expose pod redis --name=mvc --port=6379
rwaahmedmahmoud99@privatevm-tf:~$ kubectl get svc