#!/usr/bin/env bash

if ! [ $(id -u) = 0 ]; then
   echo "Run it as root!!"
   exit 1
fi

INTERFACE=$(ls -d /sys/class/net/enp0* | cut -d '/' -f 5)
if [ -z "${INTERFACE}" ]; then
    echo "No interfaces found.."
    exit 1
fi

ip link set dev ${INTERFACE} up
if pgrep -x "dhclient" > /dev/null; then
    dhclient -r
fi
dhclient -v ${INTERFACE}

# Stops connection dying when phone sleeps
adb shell 'svc power stayon usb'

# Turns screen off
sleep 2 && adb shell input keyevent 26
