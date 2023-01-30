#!/bin/sh

# SETUP DEVICE AND DRIVER
echo "maxretry = 5" > /etc/nut/ups.conf
echo "[ups]" >> /etc/nut/ups.conf
echo "driver = $UPS_DRIVER" >> /etc/nut/ups.conf
echo "port = $UPS_PORT" >> /etc/nut/ups.conf
echo "pollinterval = 15" >> /etc/nut/ups.conf

# ALLOW API ACCESS
echo "LISTEN $REMOTE_IP 3493" > /etc/nut/upsd.conf
echo "MAXAGE 25" >> /etc/nut/upsd.conf

# SETUP USERS
echo "[$UPS_USER]" >> /etc/nut/upsd.users
echo "password = $UPS_PASSWORD" >> /etc/nut/upsd.users
echo "upsmon primary" >> /etc/nut/upsd.users

# SETUP MONITORING
echo "MONITOR ups@localhost 1 $UPS_USER $UPS_PASSWORD primary" > /etc/nut/upsmon.conf

# FIX PERMISSIONS
chown -R nut:nut /dev/bus/usb /var/run/nut

# START DRIVER
upsdrvctl -u nut start

# START SERVER
upsd -u nut

# START MONITOR
upsmon -D
