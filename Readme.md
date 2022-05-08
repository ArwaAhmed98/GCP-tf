# Google cloud project (GCP)
- The main task was to create infrastructure as a tool on GCP using Terraform
### it consists of:
* 1 VPC consists of 2 subnets (management subnet & restricted subnet):
    * NAT gateway in the management subnet
    * Private VM in the  management subnet to access cluster
    * Private Kubernetes cluster in restricted subnet
    * 1 Service account used by node in the cluster to push the image of python app from GCR (Google container registry) into the cluster nodes with permission ` storage.admin` found in ` clusternodes.tf`
### Dockerize python app an push the image to GCR (Google container registry) 
---
### push the image and deploy the app on the cluster nodes:
* the deployment is donr manually using kubectl
* cluster is built using Terraform in `cluster.tf`
* the cluster control plane is accessed by the private VM ` restircted-subnet `
### steps of deployment:
`NOTE: you can either run deploy.sh bash file on your privateVM or run manually each command `
* create the ConfigMap , it contains the configuration vars needed by the applciation
  Run ` kubectl apply -f configMap.yml` on the VM
* create the deployment of your app 
  Run ` kubectl apply -f deployapp.yaml`
* expose your deployment on port 80 HTTP  LoadBalancer of target application port 8000 (80:8000)
  Run `kubectl expose deployment <deployment_name> --type LoadBalancer --port 80 --target-port 8000`
* create a pod for redis database which is used by our app
  Run `kubectl run redis --image=redis`
* expose redis pod to the service on the redishost called mvc in our case, on redis port `6379` .
  Run `kubectl expose pod redis --name=<REDHIS_HOST> --port=6379` 
* NOW, you've finished . Run `kubectl get svc` and Hit your EXTERNALIP you will get your app running