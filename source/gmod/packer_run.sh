#!/bin/bash
# set gmod specific (local) env variables
GMOD_MAX_PLAYERS='42'
GMOD_COLLECTION_ID='1234566789'
GMOD_START_MAP='ttt_my_map_name'
export GMOD_SERVER_START_PARAMS="-console -maxplayers ${GMOD_MAX_PLAYERS} -game garrysmod +gamemode terrortown +host_workshop_collection ${GMOD_COLLECTION_ID} +map ${GMOD_START_MAP}"
# set Hetzner access token
export HETZNER_TOKEN='mytoken'
# run the packer config
packer build packer-hetzner-builder.json
