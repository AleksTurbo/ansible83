output "internal_ip" {
  value = { for k, v in yandex_compute_instance.vm : k => v.network_interface[*].ip_address }
}

output "nat_ip" {
  value = { for k, v in yandex_compute_instance.vm : k => v.network_interface[*].nat_ip_address }
}
