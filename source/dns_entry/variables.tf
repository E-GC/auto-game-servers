variable "dns_subdomain_name" {
  type = string
  description = "The name of the subdomain prefix. Example: value: \"gmod\" gmod.yourdomain.com"
}

variable "dns_entry_type" {
  type = string
  description = "Type of the DNS entry. Example: A, AAAA, CNAME, SRV,..."
  default = "A"
}

variable "cloudflare_domain_zone_id" {
  type = string
  description = "The Cloudflare Domain Zone ID of the target domain."
}

variable "dns_value" {
  type = string
  description = "The value to set the DNS entry to. Example: 1.1.1.1"
}