variable "application_name" {
  type        = string
  description = "The name of the application in lower case (e.g. csgo or gmod)."
}

variable "hcloud_token" {
  type        = string
  description = "Hetzner API token (can be retrieved at https://console.hetzner.cloud/projects > [project name] > Access > API-Tokens)."
  default     = "<replace-me>"
}

variable "hcloud_location" {
  type        = string
  description = "The server location the instance should be launched at (e.g fsn1 for Falkenstein - a list of all available location can be retrieved at https://docs.hetzner.cloud/#locations)."
  default     = "<replace-me>"
}

variable "hcloud_ssh_keys" {
  type        = list(string)
  description = "The SSH keys which should be added to this server (have a look at https://console.hetzner.cloud/projects > [project name] > Access > SSH-Keys)"
  default     = []
}

variable "cloudflare_api_token" {
  type        = string
  description = "The Cloudflare API token to use (see https://support.cloudflare.com/hc/en-us/articles/200167836-Managing-API-Tokens-and-Keys)."
  default     = "<replace-me>"
}

variable "cloudflare_domain_zone_id" {
  type        = string
  description = "The Cloudflare Zone ID (see https://community.cloudflare.com/t/where-to-find-zone-id/132913)"
  default     = "<replace-me>"
}
