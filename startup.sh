#!/bin/sh

echo "[ups]" > /etc/nut/ups.conf
echo "driver = $UPS_DRIVER" >> /etc/nut/ups.conf
echo "port = $UPS_PORT" >> /etc/nut/ups.conf

echo "[$UPS_USER]" > /etc/nut/upsd.users
echo "password = $UPS_PASSWORD" >> /etc/nut/upsd.users
echo "upsmon primary" >> /etc/nut/upsd.users
echo "actions = SET" >> /etc/nut/upsd.users
echo "instcmds = ALL" >> /etc/nut/upsd.users

echo "MONITOR ups@localhost 1 $UPS_USER $UPS_PASSWORD primary" > /etc/nut/upsmon.conf

# Change perms of nut run dirs
chown -R nut:nut /dev/bus/usb /var/run/nut

# Start the drivers as the nut user
upsdrvctl -u nut start

# Start the UPSD as nut
upsd -u nut

# start UPSMon
upsmon -D
