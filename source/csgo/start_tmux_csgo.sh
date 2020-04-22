#!/bin/bash
STEAM_HOME=/home/steam
CSGO_HOME=$STEAM_HOME/csgo
IP_ADDRESS=$(ip addr show eth0 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
tmux new-session -d -s csgo-server
# shellcheck disable=SC2154
tmux send-keys -t csgo-server "$CSGO_HOME/./srcds_run -game csgo -console -maxplayers_override ${csgo_maxplayers} -tickrate 128 -authkey '${steam_authkey}' -usercon +ip \"$IP_ADDRESS\" +sv_setsteamaccount '${csgo_game_server_login_token}' +game_type '${csgo_game_type}' +game_mode '${csgo_game_mode}' +hostname '${csgo_server_hostname}' +host_workshop_map '${csgo_workshopmap}' +password '${csgo_password}' +rcon_password '${csgo_rcon_password}' ${csgo_start_parameters}" Enter
