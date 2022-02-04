variable "hcloud_server_type" {
  type    = string
  default = "cx21"
}

variable "dns_subdomain_name" {
  type    = string
  default = "gmod"
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