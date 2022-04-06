#!/bin/bash

set -ex

source /root/autogameservers/helper.sh

if [ -z "$STEAM_HOME" ]; then
  echo "please set STEAM_HOME env variable"
  exit 1
fi

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

info 'BEGIN Install GMod'
su steam -c "/home/steam/./steamcmd +force_install_dir ${GMOD_HOME} +login anonymous +app_update 4020 validate +quit"
info 'END Install GMod'

info 'BEGIN Install CS Source'
su steam -c "/home/steam/./steamcmd +force_install_dir ${STEAM_HOME}/css +login anonymous +app_update 232330 validate +quit"
mkdir_gmod 'garrysmod/cfg'
touch_gmod 'garrysmod/cfg/mount.cfg'
su steam -c "tee -a ${GMOD_HOME}/garrysmod/cfg/mount.cfg <<EOF
\"mountcfg\"
{
     \"cstrike\"    \"${STEAM_HOME}/css/cstrike\"
}
EOF"
info 'END Install CS Source'

info 'BEGIN Add GMod autostart'
apt install -y tmux
touch_gmod 'start_tmux_gmod.sh'
su steam -c "tee -a ${GMOD_HOME}/start_tmux_gmod.sh <<EOF
#!/bin/bash
tmux new-session -d -s gmod-server
tmux send-keys -t gmod-server \"${GMOD_HOME}/./srcds_run $GMOD_SERVER_START_PARAMS\" Enter
EOF"
chmodx_gmod 'start_tmux_gmod.sh'
su steam -c "(crontab -l 2>/dev/null; echo \"@reboot ${GMOD_HOME}/start_tmux_gmod.sh\") | crontab -"
info 'END Add GMod autostart'

info 'BEGIN Unpack Gmod custom contents'
mv /root/autogameservers/gmod-content.tar.gz "$GMOD_HOME/garrysmod/gmod-content.tar.gz"
chown steam:steam "$GMOD_HOME/garrysmod/gmod-content.tar.gz"
su steam -c "tar -xzf /home/steam/gmod/garrysmod/gmod-content.tar.gz -C /home/steam/gmod/garrysmod/"
info 'END Unpack Gmod custom contents'

info 'BEGIN Run initial GMod startup'
touch_gmod garrysmod/console.log
GMOD_COMMAND="su steam -c \"$GMOD_HOME/./srcds_run $GMOD_SERVER_START_PARAMS -condebug -norestart\""
tmux new-session -d -s gmod_init
tmux send-keys -t gmod_init "$GMOD_COMMAND" ENTER
sed '/VAC secure mode is activated./ q' </home/steam/gmod/garrysmod/console.log
tail -f /home/steam/gmod/garrysmod/console.log | sed '/VAC secure mode is activated./ q'
fuser -k -SIGTERM 27015/tcp
rm /home/steam/gmod/garrysmod/console.log
info 'END Run initial GMod startup'
