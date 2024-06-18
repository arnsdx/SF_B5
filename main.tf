terraform {
  required_version = ">= 1.8.5"
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = ">= 0.121.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = "yc_key.json" 
  cloud_id = "b1g8turf4kbcqi6frgkf"
  folder_id = "b1g7uc1o2ksdq1aj9rr2"
  zone = "ru-central1-a"
}

data "yandex_compute_image" "lemp_image" {
  family = "lemp"
}

resource "yandex_compute_instance" "vm-1" {
  name = "vm-1"
  resources {
    cores = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.lemp_image.id
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.sf-b7-default-subnet.id
    nat = true
  }
  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_yandex.pub")}"
  }
}

resource "yandex_vpc_network" "sf-b7-network" {}

resource "yandex_vpc_subnet" "sf-b7-default-subnet" {
  network_id = yandex_vpc_network.sf-b7-network.id
  zone = "ru-central1-a"
  v4_cidr_blocks = ["10.127.10.0/24"]
}

output "internal_ip_vm-1" {
  value = yandex_compute_instance.vm-1.network_interface.0.ip_address
}

output "external_ip_vm-1" {
  value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}