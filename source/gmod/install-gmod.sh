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

echo '[INFO] - Updating system'
set -ex
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update -y
apt dist-upgrade -y
echo '[INFO] - END Updating system'

echo '[INFO] - Install SteamCMD'
useradd -m steam
cd ${STEAM_HOME}
echo steam steam/question select "I AGREE" | sudo debconf-set-selections
echo steam steam/license note '' | sudo debconf-set-selections
apt install -y lib32gcc-s1 steamcmd
ln -s /usr/games/steamcmd /home/steam/steamcmd
echo '[INFO] - END Install SteamCMD'

echo '[INFO] - Install GMod'
su steam -c "/home/steam/./steamcmd +force_install_dir ${GMOD_HOME} +login anonymous +app_update 4020 validate +quit"
echo '[INFO] - END Install GMod'

echo '[INFO] - Install CS Source'
su steam -c "/home/steam/./steamcmd +force_install_dir ${STEAM_HOME}/css +login anonymous +app_update 232330 validate +quit"
mkdir_gmod 'garrysmod/cfg'
touch_gmod 'garrysmod/cfg/mount.cfg'
su steam -c "tee -a ${GMOD_HOME}/garrysmod/cfg/mount.cfg <<EOF
\"mountcfg\"
{
     \"cstrike\"    \"${STEAM_HOME}/css/cstrike\"
}
EOF"
echo '[INFO] - END Install CS Source'

echo '[INFO] - Add GMod autostart'
apt install -y tmux
touch_gmod 'start_tmux_gmod.sh'
su steam -c "tee -a ${GMOD_HOME}/start_tmux_gmod.sh <<EOF
#!/bin/bash
tmux new-session -d -s gmod-server
tmux send-keys -t gmod-server \"${GMOD_HOME}/./srcds_run $GMOD_SERVER_START_PARAMS\" Enter
EOF"
chmodx_gmod 'start_tmux_gmod.sh'
su steam -c "(crontab -l 2>/dev/null; echo \"@reboot ${GMOD_HOME}/start_tmux_gmod.sh\") | crontab -"
echo '[INFO] - END Add GMod autostart'
