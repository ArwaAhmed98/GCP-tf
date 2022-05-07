# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "primary" {
  name                     = "primary"
  location                 = "us-east1-b" #location of master node and nodes
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc_net.id
  subnetwork               = google_compute_subnetwork.restricted-subnetwork.id
  # logging_service          = "logging.googleapis.com/kubernetes" #hashed because it is not free
  # monitoring_service       = "monitoring.googleapis.com/kubernetes" #hashed because it is not free

  addons_config {
    http_load_balancing {
      disabled = false
    }
    horizontal_pod_autoscaling {
      disabled = true
    }
  }
  # node_locations = ["us-east1-b"] #node location is for multiregional cluster Lma bashelha 3shan ana 3yza 23ml zonal bydrb  
  # workload_identity_config {
  #   workload_pool = "arwa-348512.svc.id.goog"
  # }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"     #pods
    services_secondary_range_name = "k8s-service-range" #cluster-ips
  }

  private_cluster_config {
    enable_private_nodes    = true #make it a private cluster , will one use private ips from private subnet for k8s nodes
    enable_private_endpoint = true #allow basition host to connect to your cluster 
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  #   Jenkins use case
  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "10.0.0.0/18"
      display_name = "private-subnet-w-jenkins"
    }
  }
}
