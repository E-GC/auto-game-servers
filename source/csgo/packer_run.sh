#!/bin/bash
# set Hetzner access token
export HETZNER_TOKEN='mytoken'
# run the packer config
packer build packer-hetzner-builder.json
