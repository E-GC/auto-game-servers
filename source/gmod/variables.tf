variable "hcloud_token" {
  type = string
}

variable "hcloud_server_name" {
  type    = string
  default = "gmod-server"
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

variable "cloudflare_email" {
  type = string
}

variable "cloudflare_api_key" {
  type = string
}

variable "cloudflare_subdomain_name" {
  type    = string
  default = "gmod"
}

variable "cloudflare_domain_zone_id" {
  type = string
}