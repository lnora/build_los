#!/bin/bash

PATH="$HOME/bin:$HOME/platform-tools:$PATH"

if [ "$USE_CCACHE" = 1 ]; then
  ccache -M $CCACHE_SIZE 2>&1
fi

git config --global user.name $USER_NAME
git config --global user.email $USER_MAIL

cd ~/android/lineage

#if [ ! -d .repo ]; then
#  repo init -u https://github.com/LineageOS/android.git -b lineage-16.0
#fi

#repo sync --force-sync --no-clone-bundle -c -j8 --no-tags

git clone https://github.com/lnora/android_device_xiaomi_lavender.git device/xiaomi/lavender
git clone https://github.com/lnora/proprietary_vendor_xiaomi_lavender.git vendor/xiaomi/lavender
git clone https://github.com/lnora/android_kernel_xiaomi_lavender.git kernel/xiaomi/lavender
git clone https://github.com/LineageOS/android_packages_resources_devicesettings -b lineage-16.0 packages/resources/devicesettings

source build/envsetup.sh
breakfast lavender
croot
brunch lavender
