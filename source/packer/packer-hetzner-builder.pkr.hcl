variable "gmod_server_start_params" {
  type    = string
  default = "${env("GMOD_SERVER_START_PARAMS")}"
}

variable "steam_home" {
  type    = string
  default = "/home/steam"
}

variable "autogameservers_home" {
  type = string
  default = "/root/autogameservers"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

local "hetzner_token" {
  expression = vault("secret/data/autogameservers/hetzner", "api_key")
  sensitive  = true
}

source "hcloud" "instance" {
  image        = "ubuntu-20.04"
  location     = "fsn1"
  server_type  = "cpx11"
  ssh_username = "root"
  token        = "${local.hetzner_token}"
}

build {
  name = "gmod"

  source "source.hcloud.instance" {
    snapshot_labels = {
      application = "autogameservers"
      packer_name = "gmod"
    }
    snapshot_name = "packer gmod ${local.timestamp}"
  }

  provisioner "shell" {
    inline = [
      "mkdir -p ${var.autogameservers_home}"
    ]
  }

  provisioner "file" {
    destination = "${var.autogameservers_home}/gmod-content.tar.gz"
    source      = "./gamefiles/gmod/gmod-content.tar.gz"
  }

  provisioner "file" {
    destination = "${var.autogameservers_home}/helper.sh"
    source = "./scripts/helper.sh"
  }

  // install steam cmd
  provisioner "shell" {
    environment_vars = [
      "STEAM_HOME=${var.steam_home}"
    ]
    script = "./scripts/install-steamcmd.sh"
  }

  // install gmod
  provisioner "shell" {
    environment_vars = [
      "STEAM_HOME=${var.steam_home}",
      "GMOD_SERVER_START_PARAMS=${var.gmod_server_start_params}"
    ]
    script = "./scripts/games/install-gmod.sh"
  }
}
