resource "hcloud_server" "instance" {
  image       = data.hcloud_image.gmod.id
  name        = var.hcloud_server_name
  server_type = var.hcloud_server_type
  location    = var.hcloud_location
  ssh_keys    = var.hcloud_ssh_keys
}

data "hcloud_image" "gmod" {
  most_recent = true
  with_selector = "packer_name=gmod"
}

resource "cloudflare_record" "gmod_dns" {
  name    = var.cloudflare_subdomain_name
  type    = "A"
  zone_id = var.cloudflare_domain_zone_id
  value   = hcloud_server.instance.ipv4_address
}
