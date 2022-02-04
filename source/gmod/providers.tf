provider "hcloud" {
  token   = module.globals.hcloud_token
}

provider "cloudflare" {
  api_token = module.globals.cloudflare_api_token
}

module "globals" {
  source           = "../globals"
  application_name = "gmod"
  vault_addr = var.vault_addr
  vault_role_id   = var.vault_role_id
  vault_secret_id = var.vault_secret_id
}

module "dns_entry" {
  source                    = "../dns_entry"
  cloudflare_domain_zone_id = module.globals.cloudflare_domain_zone_id
  dns_subdomain_name        = var.dns_subdomain_name
  dns_value                 = hcloud_server.instance.ipv4_address
}
