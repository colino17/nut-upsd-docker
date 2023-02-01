FROM alpine:latest

# ENVIRONMENT
ENV TZ=Canada/Atlantic
ENV UPS_DRIVER="usbhid-ups"
ENV UPS_PORT="auto"
ENV UPS_USER="admin"
ENV UPS_PASSWORD="password"

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

# HEALTHCHECK
HEALTHCHECK --interval=25s --timeout=5s --retries=5 \
  CMD upsc ups > /dev/stdout 2> /dev/null | grep ups || killall -9 upsmon

# PORTS
EXPOSE 3493

# COMMAND
ENTRYPOINT ["./startup.sh"]
