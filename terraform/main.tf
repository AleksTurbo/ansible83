provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.yc_cloud_id
  folder_id                = var.yc_folder_id
  zone                     = var.yc_zone
}

data "yandex_compute_image" "centos" {
  family = "centos-stream-8"
}

locals {
  vm_image_map = data.yandex_compute_image.centos.id
  vm_name      = toset(["clickhouse", "vector", "lighthouse"])
}


resource "yandex_compute_instance" "vm" {
  for_each    = local.vm_name
  name        = "${each.key}-01"
  hostname    = "${each.value}-01.local"
  platform_id = "standard-v1"
  description = "Srv-${each.value}"

  resources {
    cores  = 2
    memory = 4
  }


  boot_disk {
    initialize_params {
      image_id = local.vm_image_map
      type     = "network-hdd"
      size     = 20
    }
  }


  network_interface {
    subnet_id = yandex_vpc_subnet.vpcsubnet.id
    nat       = true
    ipv6      = false
  }


  metadata = {
        ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"

  }



}
