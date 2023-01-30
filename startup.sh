#!/bin/sh

# SETUP DEVICE AND DRIVER
echo "maxretry = 5" > /etc/nut/ups.conf
echo "[ups]" >> /etc/nut/ups.conf
echo "driver = $UPS_DRIVER" >> /etc/nut/ups.conf
echo "port = $UPS_PORT" >> /etc/nut/ups.conf
echo "pollinterval = 15" >> /etc/nut/ups.conf

# ALLOW API ACCESS
echo "LISTEN 0.0.0.0 3493" > /etc/nut/upsd.conf

# SETUP USERS
echo "[$UPS_USER]" > /etc/nut/upsd.users
echo "password = $UPS_PASSWORD" >> /etc/nut/upsd.users
echo "actions = set" >> /etc/nut/upsd.users
echo "actions = fsd" >> /etc/nut/upsd.users
echo "instcmds = all" >> /etc/nut/upsd.users
echo "upsmon master" >> /etc/nut/upsd.users

# SETUP MONITORING
echo "MONITOR ups@localhost 1 $UPS_USER $UPS_PASSWORD master" > /etc/nut/upsmon.conf

# FIX PERMISSIONS
chown -R nut:nut /dev/bus/usb /var/run/nut

# START DRIVER
upsdrvctl -u nut start

# START SERVER
upsd -u nut
