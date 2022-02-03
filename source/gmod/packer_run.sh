#!/bin/bash

if [ -z "$HETZNER_TOKEN" ]; then
  echo "hetzner cloud token (HETZNER_TOKEN) is not set"
  exit 1
fi

if [ -z "$GMOD_MAX_PLAYERS" ] || [ -z "$GMOD_COLLECTION_ID" ] || [ -z "$GMOD_START_MAP" ]; then
  echo "gmod variables (GMOD_MAX_PLAYERS, GMOD_COLLECTION_ID, GMOD_START_MAP) not set"
  exit 1
fi

# set gmod specific (local) env variables
export GMOD_SERVER_START_PARAMS="-console -maxplayers ${GMOD_MAX_PLAYERS} -game garrysmod +gamemode terrortown +host_workshop_collection ${GMOD_COLLECTION_ID} +map ${GMOD_START_MAP}"
# run the packer config
packer build packer-hetzner-builder.json
