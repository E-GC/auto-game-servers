resource "cloudflare_record" "dns_record" {
  name    = var.dns_subdomain_name
  type    = var.dns_entry_type
  zone_id = var.cloudflare_domain_zone_id
  value   = var.dns_value
}
