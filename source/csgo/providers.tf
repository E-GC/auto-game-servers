provider "hcloud" {
  version = "~> 1.16"
  token   = module.globals.hcloud_token
}

provider "cloudflare" {
  version   = "~> 2.0"
  api_token = module.globals.cloudflare_api_token
}

module "globals" {
  source = "../globals"
  application_name = "csgo"
}

module "dns_entry" {
  source                    = "../dns_entry"
  cloudflare_domain_zone_id = module.globals.cloudflare_domain_zone_id
  dns_subdomain_name        = var.dns_subdomain_name
  dns_value                 = hcloud_server.instance.ipv4_address
}
