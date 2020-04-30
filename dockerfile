FROM alpine

# Install all needed
RUN apk update && apk upgrade && apk add nginx php7-fpm openssl openrc --no-cache
#RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

# Set user to root
USER root

# Replacing the default config
COPY srcs/index.html /var/lib/nginx/index.html
RUN rm -f /etc/nginx/init.d/default.conf
COPY srcs/default.conf /etc/nginx/conf.d/

# Generate SSL keys
RUN mkdir /ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=thgermai' -keyout /ssl/key.pem -out /ssl/cert.pem

# Booting openrc
RUN openrc boot
RUN touch /run/openrc/softlevel

# Create the file for running nginx
RUN mkdir -p /run/nginx

# Open ports
EXPOSE 80 443

# Start nginx at the run
#RUN rc-update add telegraf
ENTRYPOINT service php-fpm7 start; nginx -g "daemon off;"
#ENTRYPOINT service php-fpm7 start; service telegraf start;  nginx -g "daemon off;"

