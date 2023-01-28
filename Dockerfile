FROM alpine:latest

# ENVIRONMENT
ENV TZ=Canada/Atlantic
ENV UPS_NAME="ups"
ENV UPS_DESC="UPS"
ENV UPS_DRIVER="usbhid-ups"
ENV UPS_PORT="auto"
ENV UPS_USER="user"
ENV UPS_PASSWORD="password"
ENV ADMIN_PASSWORD=""
ENV SHUTDOWN_CMD="echo 'System shutdown not configured!'"

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

RUN mkdir -p /var/run/nut && \
    chown nut:nut /var/run/nut && \
    chmod 700 /var/run/nut

# PORTS
EXPOSE 3493

# COMMAND
ENTRYPOINT ["./startup.sh"]
