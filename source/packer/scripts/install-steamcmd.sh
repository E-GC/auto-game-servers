#!/bin/bash

set -ex

source /root/autogameservers/helper.sh

if [ -z "$STEAM_HOME" ]; then
  echo "please set STEAM_HOME env variable"
  exit 1
fi


info 'BEGIN Updating system'
apt update -y
apt install -y software-properties-common
add-apt-repository -y multiverse
dpkg --add-architecture i386
apt update -y
apt dist-upgrade -y
info 'END Updating system'

info 'BEGIN Install SteamCMD'
useradd -m steam
cd "${STEAM_HOME}"
echo steam steam/question select "I AGREE" | debconf-set-selections
echo steam steam/license note '' | debconf-set-selections
apt install -y lib32gcc-s1 steamcmd
ln -s /usr/games/steamcmd /home/steam/steamcmd
info 'END Install SteamCMD'

set +ex
