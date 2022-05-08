# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster
resource "google_container_cluster" "primary" {
  name                     = "primary"
  location                 = "us-east1-b" #location of master node and nodes
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc_net.id
  subnetwork               = google_compute_subnetwork.restricted-subnetwork.id
  ip_allocation_policy { #lazem tb2a mwgoda w fdya 3shan yt3mlha enableeeeeeee
    #   cluster_secondary_range_name  = "k8s-pod-range"     #pods
    #   services_secondary_range_name = "k8s-service-range" #cluster-ips
  }

  private_cluster_config {
    enable_private_nodes    = true #make it a private cluster , will one use private ips from private subnet for k8s nodes
    enable_private_endpoint = true #allow basition host to connect to your cluster 
    master_ipv4_cidr_block  = "192.168.1.0/28"
  }


  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = var.public_sub_cidr
      display_name = "managSUB"
    }
  }
}
