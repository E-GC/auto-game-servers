#!/bin/bash

if [ -z "$VAULT_TOKEN" ] || [ -z "$VAULT_ADDR" ]; then
  echo "vault specific env vars (VAULT_TOKEN, VAULT_ADDR) not set"
  exit 1
fi

if [ -z "$GMOD_MAX_PLAYERS" ] || [ -z "$GMOD_COLLECTION_ID" ] || [ -z "$GMOD_START_MAP" ]; then
  echo "gmod variables (GMOD_MAX_PLAYERS, GMOD_COLLECTION_ID, GMOD_START_MAP) not set"
  exit 1
fi

# set gmod specific (local) env variables
export GMOD_SERVER_START_PARAMS="-console -maxplayers ${GMOD_MAX_PLAYERS} -game garrysmod +gamemode terrortown +host_workshop_collection ${GMOD_COLLECTION_ID} +map ${GMOD_START_MAP}"
# run the packer config
packer build -only gmod.* packer-hetzner-builder.pkr.hcl
