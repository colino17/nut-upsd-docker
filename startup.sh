#!/bin/sh

echo "[ups]" > /etc/nut/ups.conf
echo "driver = $UPS_DRIVER" >> /etc/nut/ups.conf
echo "port = $UPS_PORT" >> /etc/nut/ups.conf

echo "LISTEN 0.0.0.0 3493" > /etc/nut/upsd.conf

echo "[$ADMIN_USER]" > /etc/nut/upsd.users
echo "password = $ADMIN_PASSWORD" >> /etc/nut/upsd.users
echo "actions = set" >> /etc/nut/upsd.users
echo "actions = fsd" >> /etc/nut/upsd.users
echo "instcmds = all" >> /etc/nut/upsd.users
echo "" >> /etc/nut/upsd.users
echo "[$API_USER]" >> /etc/nut/upsd.users
echo "password = $API_PASSWORD" >> /etc/nut/upsd.users
echo upsmon master

echo "MONITOR ups@localhost 1 $API_USER $API_PASSWORD master" > /etc/nut/upsmon.conf

# Change perms of nut run dirs
chown -R nut:nut /dev/bus/usb /var/run/nut

# Start the drivers as the nut user
upsdrvctl -u nut start

# Start the UPSD as nut
upsd -u nut

# start UPSMon
upsmon -D
