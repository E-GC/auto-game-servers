#!/bin/bash
STEAM_HOME=/home/steam
CSGO_HOME=$STEAM_HOME/csgo

echo '[INFO] - Add CS:GO autostart'
su steam -c "(crontab -l 2>/dev/null; echo \"@reboot $CSGO_HOME/start_tmux_csgo.sh\") | crontab -"
su steam -c "bash $CSGO_HOME/start_tmux_csgo.sh"
echo '[INFO] - END Add CS:GO autostart'
