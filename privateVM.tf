resource "google_compute_instance" "vm_instance_public" {
  name         = "privatevm-tf"
  zone         = var.zone
  machine_type = var.linux_instance_type
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = var.ubuntu_2004_sku
    }
  }
  metadata_startup_script = "sudo apt-get update"
  network_interface {
    network    = google_compute_network.vpc_net.id
    subnetwork = google_compute_subnetwork.managment-subnetwork.id
  }
}