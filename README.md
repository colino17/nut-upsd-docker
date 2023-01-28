# WHAT IS IT?

A docker container running NUT UPS Daemon (driver, server, and monitor).

# COMPOSE

```
version: '3'
services:
  ups:
    image: ghcr.io/colino17/nutupsd-docker:latest
    container_name: ups
    restart: unless-stopped
    devices:
      - /dev/bus/usb/busnumber:/dev/bus/usb/busnumber
    environment:
      - TZ=Canada/Atlantic
      - UPS_DRIVER="usbhid-ups"
      - UPS_PORT="auto"
      - UPS_USER="admin"
      - UPS_PASSWORD="password"
    ports:
      - 3493:3493
```

# CREDITS AND SOURCES

- https://networkupstools.org/
