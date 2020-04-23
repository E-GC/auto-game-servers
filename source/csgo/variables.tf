variable "hcloud_token" {
  type = string
}

variable "hcloud_server_name" {
  type    = string
  default = "csgo-server"
}

variable "hcloud_server_type" {
  type    = string
  default = "cx21"
}

variable "hcloud_location" {
  type    = string
  default = "fsn1"
}

variable "hcloud_ssh_keys" {
  type    = list(string)
  default = []
}

variable "cloudflare_api_token" {
  type = string
}

variable "cloudflare_domain_zone_id" {
  type = string
}

variable "dns_subdomain_name" {
  type    = string
  default = "csgo"
}

variable "steam_authkey" {
  type = string
}

variable "csgo_game_server_login_token" {
  type = string
}

variable "csgo_game_type" {
  type = number
}

variable "csgo_game_mode" {
  type = number
}

variable "csgo_server_hostname" {
  type = string
}

variable "csgo_maxplayers" {
  type = number
}

variable "csgo_workshopmap" {
  type = string
}

variable "csgo_password" {
  type = string
}

variable "csgo_rcon_password" {
  type = string
}

variable "csgo_start_parameters" {
  type = string
}