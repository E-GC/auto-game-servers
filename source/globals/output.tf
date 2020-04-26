output "hcloud_image_selector" {
  value = "packer_name=${var.application_name}"
}

output "hcloud_server_name" {
  value = "${var.application_name}-server"
}

output "hcloud_token" {
  value     = var.hcloud_token
  sensitive = true
}

output "hcloud_location" {
  value = var.hcloud_location
}

output "hcloud_ssh_keys" {
  value = var.hcloud_ssh_keys
}

output "cloudflare_api_token" {
  value     = var.cloudflare_api_token
  sensitive = true
}

output "cloudflare_domain_zone_id" {
  value = var.cloudflare_domain_zone_id
}
