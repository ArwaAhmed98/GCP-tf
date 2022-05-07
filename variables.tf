
variable "public_sub_cidr" {
  type = string
}

variable "private_sub_cidr" {
  type = string
}
variable "region" {
  type = string

}

variable "zone" {
  type = string

}
#vars for private instance
variable "ubuntu_2004_sku" {
  type        = string
  description = "SKU for Ubuntu 20.04 LTS"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "linux_instance_type" {
  type        = string
  description = "VM instance type for Linux Server"
  default     = "f1-micro"
}