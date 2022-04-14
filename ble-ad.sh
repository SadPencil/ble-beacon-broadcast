#!/usr/bin/env bash
set -e

# https://eclipse.github.io/kura/dev/bluetooth-le-beacon-example.html#beacon_advertising_with_hcitool_1

dev="hci0"
data="1f 02 01 04 03 03 3c fe 17 ff 00 01 b5 00 02 41 1c 49 70 00 00 00 ca 94 93 6e 4a 01 10 00 00 00 b4"

# check root privilege
[ "$(id -u)" == 0 ] || (echo Please run as root. && exit 1)

# turn on the device
hciconfig "${dev}" up

# set the raw data
hcitool -i "${dev}" cmd 0x08 0x0008 ${data}

# set broadcast interval to 1 second
hcitool -i "${dev}" cmd 0x08 0x0006 a0 00 a0 00 03 00 00 00 00 00 00 00 00 07 00

# begin broadcast
hcitool -i "${dev}" cmd 0x08 0x000a 01
