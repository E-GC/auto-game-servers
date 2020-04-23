#!/bin/bash
STEAM_HOME=/home/steam
CSGO_HOME=${STEAM_HOME}/csgo
function touch_csgo {
  su steam -c "touch ${CSGO_HOME}/$1"
}
function chmodx_csgo {
  su steam -c "chmod +x ${CSGO_HOME}/$1"
}
function mkdir_csgo {
  su steam -c "mkdir -p ${CSGO_HOME}/$1"
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
# set bash
chsh -s /bin/bash steam
cd ${STEAM_HOME}
apt install -y lib32gcc1 lib32tinfo5 libstdc++6:i386
su steam -c 'curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -'
echo '[INFO] - END Install SteamCMD'

echo '[INFO] - Install CS:GO'
su steam -c "/home/steam/./steamcmd.sh +login anonymous +force_install_dir ${CSGO_HOME} +app_update 740 validate +quit"
echo '[INFO] - END Install CS:GO'

echo '[INFO] - Install tmux'
apt install -y tmux
echo '[INFO] - END Install tmux'
