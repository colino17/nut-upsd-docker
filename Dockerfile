FROM alpine:latest

# ENVIRONMENT
ENV TZ=Canada/Atlantic
ENV UPS_DRIVER="usbhid-ups"
ENV UPS_PORT="auto"
ENV UPS_USER="admin"
ENV UPS_PASSWORD="password"
ENV REMOTE_IP=127.0.0.1

# NUT PACKAGES
RUN apk update
RUN apk upgrade
RUN apk add --no-cache nut

# TIMEZONE
RUN apk update && apk add --no-cache tzdata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# FILES
ADD startup.sh /

# PERMISSIONS
RUN chmod +x /startup.sh
RUN mkdir -p /var/run/nut

# PORTS
EXPOSE 3493

# COMMAND
ENTRYPOINT ["./startup.sh"]
