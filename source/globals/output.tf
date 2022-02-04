output "hcloud_image_selector" {
  value = "packer_name=${var.application_name}"
}

output "hcloud_server_name" {
  value = "${var.application_name}-server"
}

output "hcloud_token" {
  value     = lookup(data.vault_generic_secret.hetzner_api.data, "api_key", "<not-found>")
  sensitive = true
}

output "hcloud_location" {
  value = var.hcloud_location
}

output "hcloud_ssh_keys" {
  value = var.hcloud_ssh_keys
}

output "cloudflare_api_token" {
  value     = lookup(data.vault_generic_secret.cloudflare_api.data, "api_token", "<not-found>")
  description = "The Cloudflare API token to use (see https://support.cloudflare.com/hc/en-us/articles/200167836-Managing-API-Tokens-and-Keys)."
  sensitive = true
}

output "cloudflare_domain_zone_id" {
  value = lookup(data.vault_generic_secret.cloudflare_api.data, "domain_zone_id", "<not-found>")
  description = "The Cloudflare Zone ID (see https://community.cloudflare.com/t/where-to-find-zone-id/132913)"
}
