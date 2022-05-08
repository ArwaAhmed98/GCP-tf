resource "google_compute_router" "router" {
  name    = "my-router"
  network = google_compute_network.vpc_net.id

 
}

resource "google_compute_router_nat" "nat" {
  name                   = "my-router-nat"
  router                 = google_compute_router.router.name
  nat_ip_allocate_option = "AUTO_ONLY"
  #   How external IPs should be allocated for this NAT. Valid values are AUTO_ONLY for only allowing NAT IPs allocated by Google Cloud Platform
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.managment-subnetwork.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

}