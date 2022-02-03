#!/bin/bash
STEAM_HOME=/home/steam
GMOD_HOME=${STEAM_HOME}/gmod
function touch_gmod {
  su steam -c "touch ${GMOD_HOME}/$1"
}
function chmodx_gmod {
  su steam -c "chmod +x ${GMOD_HOME}/$1"
}
function mkdir_gmod {
  su steam -c "mkdir -p ${GMOD_HOME}/$1"
}
set -ex

echo '[INFO] - Unpack Gmod custom contents'
chown steam:steam /home/steam/gmod/garrysmod/gmod-content.tar.gz
su steam -c 'tar -xzf /home/steam/gmod/garrysmod/gmod-content.tar.gz -C /home/steam/gmod/garrysmod/'
echo '[INFO] - END Unpack Gmod custom contents'

echo '[INFO] - Run initial GMod startup'
touch_gmod garrysmod/console.log
GMOD_COMMAND="su steam -c \"/home/steam/gmod/./srcds_run $GMOD_SERVER_START_PARAMS -condebug -norestart\""
tmux new-session -d -s gmod_init
tmux send-keys -t gmod_init "$GMOD_COMMAND" ENTER
sed '/VAC secure mode is activated./ q' < /home/steam/gmod/garrysmod/console.log
tail -f /home/steam/gmod/garrysmod/console.log | sed '/VAC secure mode is activated./ q'
fuser -k -SIGTERM 27015/tcp
rm /home/steam/gmod/garrysmod/console.log
echo '[INFO] - END Run initial GMod startup'