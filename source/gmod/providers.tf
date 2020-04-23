provider "hcloud" {
  version = "~> 1.16"
  token   = var.hcloud_token
}

provider "cloudflare" {
  version   = "~> 2.0"
  api_token = var.cloudflare_api_token
}

module "dns_entry" {
  source                    = "../dns_entry"
  cloudflare_domain_zone_id = var.cloudflare_domain_zone_id
  dns_subdomain_name        = var.dns_subdomain_name
  dns_value                 = hcloud_server.instance.ipv4_address
}
