#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))


sed -i "s/DEVICE_MODEL := HC5962$/DEVICE_MODEL := HC5962 \/ B70/" target/linux/ramips/image/mt7621.mk


sed -i "s/--max-leb-cnt=96/--max-leb-cnt=128/g" target/linux/ramips/image/mt7621.mk

# Zapret feed (pinned to the OpenWrt 25.12-compatible integration branch)
grep -q '^src-git zapret ' feeds.conf.default || echo 'src-git zapret https://github.com/remittor/zapret-openwrt.git;zap1' >> feeds.conf.default
./scripts/feeds update zapret
./scripts/feeds install -p zapret zapret luci-app-zapret
