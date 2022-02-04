data "vault_generic_secret" "hetzner_api" {
  path = "secret/autogameservers/hetzner"
}

data "vault_generic_secret" "cloudflare_api" {
  path = "secret/autogameservers/cloudflare"
}
