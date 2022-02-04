variable "application_name" {
  type        = string
  description = "The name of the application in lower case (e.g. csgo or gmod)."
}

variable "vault_addr" {
  type        = string
  description = "The address of the HashiCorp Vault to connect to."
  default     = "http://127.0.0.1:8200"
}

variable "vault_role_id" {
  type        = string
  description = "The role id of the corresponding HashiCorp Vault app role."
}

variable "vault_secret_id" {
  type        = string
  description = "The secret id of the corresponding HashiCorp Vault app role."
  sensitive   = true
}

variable "hcloud_location" {
  type        = string
  description = "The server location the instance should be launched at (e.g fsn1 for Falkenstein - a list of all available location can be retrieved at https://docs.hetzner.cloud/#locations)."
  default     = "fsn1"
}

variable "hcloud_ssh_keys" {
  type        = list(string)
  description = "The SSH keys which should be added to this server (have a look at https://console.hetzner.cloud/projects > [project name] > Access > SSH-Keys)"
  default     = []
}
