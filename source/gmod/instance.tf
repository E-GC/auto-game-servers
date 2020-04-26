resource "hcloud_server" "instance" {
  image       = data.hcloud_image.gmod.id
  name        = module.globals.hcloud_server_name
  server_type = var.hcloud_server_type
  location    = module.globals.hcloud_location
  ssh_keys    = module.globals.hcloud_ssh_keys
}

data "hcloud_image" "gmod" {
  most_recent   = true
  with_selector = module.globals.hcloud_image_selector
}
