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
}
