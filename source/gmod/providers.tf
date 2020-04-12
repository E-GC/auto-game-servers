provider "hcloud" {
  version = "~> 1.16"
  token   = var.hcloud_token
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}
