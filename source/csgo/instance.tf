resource "hcloud_server" "instance" {
  image       = data.hcloud_image.csgo.id
  name        = module.globals.hcloud_server_name
  server_type = var.hcloud_server_type
  location    = module.globals.hcloud_location
  ssh_keys    = module.globals.hcloud_ssh_keys
  user_data   = data.template_file.cloudinit.rendered
}

data "hcloud_image" "csgo" {
  most_recent   = true
  with_selector = module.globals.hcloud_image_selector
}

data "template_file" "cloudinit" {
  template = <<-EOT
#cloud-config
# vim: syntax=yaml
write_files:
-   encoding: b64
    content: ${base64encode(data.template_file.csgo_crontab_script.rendered)}
    owner: steam:steam
    path: /home/steam/csgo/start_tmux_csgo.sh
    permissions: '0700'
runcmd:
 - [ echo, '[INFO] - Add CS:GO autostart' ]
 - [ su, steam, -c, "(crontab -l 2>/dev/null; echo \"@reboot /home/steam/csgo/start_tmux_csgo.sh\") | crontab -" ]
 - [ su, steam, -c, "bash /home/steam/csgo/start_tmux_csgo.sh"]
 - [ echo, '[INFO] - END Add CS:GO autostart' ]
EOT
}

data "template_file" "csgo_crontab_script" {
  template = file("${path.module}/start_tmux_csgo.sh")

  vars = {
    csgo_maxplayers              = var.csgo_maxplayers
    steam_authkey                = var.steam_authkey
    csgo_game_server_login_token = var.csgo_game_server_login_token
    csgo_game_type               = var.csgo_game_type
    csgo_game_mode               = var.csgo_game_mode
    csgo_server_hostname         = var.csgo_server_hostname
    csgo_workshopmap             = var.csgo_workshopmap
    csgo_password                = var.csgo_password
    csgo_rcon_password           = var.csgo_rcon_password
    csgo_start_parameters        = var.csgo_start_parameters
  }
}