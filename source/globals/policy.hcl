path "secret/data/autogameservers/*" {
  capabilities = ["read"]
}

path "auth/token/create" {
  capabilities = ["create", "read", "update", "list"]
}
