#!/bin/bash

if [ -z "$VAULT_ADDR" ]; then
  echo "vault address (VAULT_ADDR) has to be set"
  exit 1
fi

if [ -z "$VAULT_TOKEN" ]; then
  if [ -z "$GITHUB_PERSONAL_ACCESS_TOKEN" ]; then
    echo "env variable for github personal access token (GITHUB_PERSONAL_ACCESS_TOKEN) has to be set in order to login to the vault"
    exit 1
  fi
  VAULT_TOKEN=$(vault login -format "json" -method=github token="$GITHUB_PERSONAL_ACCESS_TOKEN" | jq -cr ".auth.client_token")
fi

if [ "$1" = "gmod" ]; then
  if [ -z "$GMOD_MAX_PLAYERS" ] || [ -z "$GMOD_COLLECTION_ID" ] || [ -z "$GMOD_START_MAP" ]; then
    echo "gmod variables (GMOD_MAX_PLAYERS, GMOD_COLLECTION_ID, GMOD_START_MAP) not set"
    exit 1
  fi
  # set gmod specific (local) env variables
  export GMOD_SERVER_START_PARAMS="-console -maxplayers ${GMOD_MAX_PLAYERS} -game garrysmod +gamemode terrortown +host_workshop_collection ${GMOD_COLLECTION_ID} +map ${GMOD_START_MAP}"
  PACKER_BUILD_NAME="gmod"
elif [ "$1" = "csgo" ]; then
  echo "not yet implemented"
else
  echo "command usage: packer_run.sh <gmod|csgo>"
  exit 1
fi

echo "running ${PACKER_BUILD_NAME} server snapshot creation"

# run the packer config
VAULT_TOKEN="$VAULT_TOKEN" packer build -only "${PACKER_BUILD_NAME}.*" packer-hetzner-builder.pkr.hcl
