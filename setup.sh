#!/usr/bin/env bash

apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev
cd $HOME
curl -L -O 'https://dl.google.com/android/repository/platform-tools-latest-linux.zip'
unzip platform-tools-latest-linux.zip -d ~
# add Android SDK platform tools to path
if [ -d "$HOME/platform-tools" ] ; then
    PATH="$HOME/platform-tools:$PATH"
fi
mkdir -p ~/bin
mkdir -p ~/android/lineage
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
git config --global user.email "buildbot@docker.dock"
git config --global user.name "LineageOS Buildbot"
cd ~/android/lineage
repo init -u https://github.com/LineageOS/android.git -b lineage-16.0
repo sync
source build/envsetup.sh
breakfast lavender
croot
brunch lavender
