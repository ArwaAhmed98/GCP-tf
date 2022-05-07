resource "google_compute_network" "vpc_net" {
  name                    = "vpc-net"
  auto_create_subnetworks = false #do not create a subnet in each region
  #defualt routing mode is global which means subnets in diff. regions can communicate with each other
}

resource "google_compute_subnetwork" "managment-subnetwork" {
  name                     = "managemntsubnet-tf"
  ip_cidr_range            = var.public_sub_cidr
  private_ip_google_access = true # vms can acces google services
  network                  = google_compute_network.vpc_net.id
}

resource "google_compute_subnetwork" "restricted-subnetwork" {
  name          = "restrictedsubnet-tf"
  ip_cidr_range = var.private_sub_cidr #k8s nodes use primary range
  network       = google_compute_network.vpc_net.id
  # secondary_ip_range = [ {
  #   ip_cidr_range = "10.0.3.0/24"
  #   range_name = "k8s-pods" #if u need to open firewall to access other VMs in ur VPC from k8s , u will use this seconadry ip rang as src and optionally #service account of the k8s nodes
  #   #name of seconadry ip will be used in the GKE configuration
  # } ,{
  #   #sec sec ip range will be used for ClusterIP in k8s , when a service is created in k8s , IP  for the service will be taken from this range 
  # }]
    secondary_ip_range {
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/20"
  }
}
