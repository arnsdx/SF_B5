terraform {
  required_version = ">= 1.8.5"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.121.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = "yc_key.json"
  cloud_id                 = "b1g8turf4kbcqi6frgkf"
  folder_id                = "b1g7uc1o2ksdq1aj9rr2"
  zone                     = "ru-central1-a"
}

data "yandex_compute_image" "debian_image" {
  family = "debian-12"
}

resource "yandex_compute_instance" "vm-1" {
  name = "vm-1"
  hostname = "sf-b5-vm1"

  resources {
    cores  = 2
    memory = 2
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sf-b5-default-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "arnsdx-admin:${file("~/.ssh/id_yandex.pub")}"
    user-data = "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: arnsdx-admin\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDE/bWEwub/9IXYtbHyFp8GBlOQSvCPG7OPalfuw/791ETWkmShNrUM5Edo7Cjzl5+FhqzM+RJj/Tvve0V1CLaQEKkgmONJ92PrZaMB+F1p/0651KOvk6+z7X++ulb9Cz4tC3zeW2Yw7Lb9ShAQlWN+7Z9lQqjBor5SaE/QKYssGafIIZaafupsg7WuOqg22+5SwyrgM6QKWvo/3dAkhafqR62XERVavWt2/g2UdUYkNVbS3r7ZsWgf+W99GtH4IFHczKEPq72GawCSz75j6fth2H5Sn1KRsw2dwxcbC7RKbUAjejleoncIkNts6MlGFRWq66sLUAOyWZbJUwf7ir1qXWJdPreOtkoSZaQuJchSoQP4Wmr74wFy19h64R7ZV7yoEr02B5wWP+i8TVoD8No33XKEYTjUAxhKcdwddfDVtAVUdj+dIVkH5Qr1bg6JgSnwSuId3iv0WN5yFvMbdy9yK2/SrCOQN2ChKVV37/r6JxCD04JJnw4wxEIDAjy4GX1Ea6QCisQr7orOjS14gTVWjYYeQCSpMoChmYMTjPpt/h1Pu+dadnxQU1bWkPzeK7TBBLrokf5w549CM1ng7sw2482gr4OFEjMM+W/X3jjpkQbgtExBAbAjAHz8EJQVXyHJRabC/DBBIXGOn+EcMeUsC01mvE86KOwPFBb0ZX0Z7w==\n#cloud-config\nruncmd: []"
  }

  timeouts {
    create = "60m"
    delete = "60m"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name = "vm-2"
  hostname = "sf-b5-vm2"

  resources {
    cores  = 2
    memory = 2
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.debian_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sf-b5-default-subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "arnsdx-admin:${file("~/.ssh/id_yandex.pub")}"
    user-data = "#cloud-config\ndatasource:\n Ec2:\n  strict_id: false\nssh_pwauth: no\nusers:\n- name: arnsdx-admin\n  sudo: ALL=(ALL) NOPASSWD:ALL\n  shell: /bin/bash\n  ssh_authorized_keys:\n  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDE/bWEwub/9IXYtbHyFp8GBlOQSvCPG7OPalfuw/791ETWkmShNrUM5Edo7Cjzl5+FhqzM+RJj/Tvve0V1CLaQEKkgmONJ92PrZaMB+F1p/0651KOvk6+z7X++ulb9Cz4tC3zeW2Yw7Lb9ShAQlWN+7Z9lQqjBor5SaE/QKYssGafIIZaafupsg7WuOqg22+5SwyrgM6QKWvo/3dAkhafqR62XERVavWt2/g2UdUYkNVbS3r7ZsWgf+W99GtH4IFHczKEPq72GawCSz75j6fth2H5Sn1KRsw2dwxcbC7RKbUAjejleoncIkNts6MlGFRWq66sLUAOyWZbJUwf7ir1qXWJdPreOtkoSZaQuJchSoQP4Wmr74wFy19h64R7ZV7yoEr02B5wWP+i8TVoD8No33XKEYTjUAxhKcdwddfDVtAVUdj+dIVkH5Qr1bg6JgSnwSuId3iv0WN5yFvMbdy9yK2/SrCOQN2ChKVV37/r6JxCD04JJnw4wxEIDAjy4GX1Ea6QCisQr7orOjS14gTVWjYYeQCSpMoChmYMTjPpt/h1Pu+dadnxQU1bWkPzeK7TBBLrokf5w549CM1ng7sw2482gr4OFEjMM+W/X3jjpkQbgtExBAbAjAHz8EJQVXyHJRabC/DBBIXGOn+EcMeUsC01mvE86KOwPFBb0ZX0Z7w==\n#cloud-config\nruncmd: []"
  }

  timeouts {
    create = "60m"
    delete = "60m"
  }
}

resource "yandex_vpc_network" "sf-b5-network" {}

resource "yandex_vpc_subnet" "sf-b5-default-subnet" {
  network_id     = yandex_vpc_network.sf-b5-network.id
  zone           = "ru-central1-a"
  v4_cidr_blocks = ["10.135.10.0/24"]
}

resource "yandex_lb_target_group" "sf-b5-web-target-group" {
  name      = "sf-b5-web-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.sf-b5-default-subnet.id
    address   = yandex_compute_instance.vm-1.network_interface[0].ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.sf-b5-default-subnet.id
    address   = yandex_compute_instance.vm-2.network_interface[0].ip_address
  }
}

resource "yandex_lb_network_load_balancer" "sf-b5-loadbalancer" {
  name = "sf-b5-loadbalancer"

  listener {
    name = "sf-b5-lb-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.sf-b5-web-target-group.id

    healthcheck {
      name = "http"

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

output "internal_ip_vm-1" {
  value = yandex_compute_instance.vm-1.network_interface[0].ip_address
}

output "external_ip_vm-1" {
  value = yandex_compute_instance.vm-1.network_interface[0].nat_ip_address
}

output "internal_ip_vm-2" {
  value = yandex_compute_instance.vm-2.network_interface[0].ip_address
}

output "external_ip_vm-2" {
  value = yandex_compute_instance.vm-2.network_interface[0].nat_ip_address
}
