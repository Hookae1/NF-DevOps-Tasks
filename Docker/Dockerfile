# According to Docker BP it better to use specific docker image
FROM alpine:3.16.2

# According to Docker BP - to reduce number of layers better to include common commands in one RUN instructions "
RUN apk update && apk add --no-cache apache2

COPY index.html /var/www/localhost/htdocs

# Expose the port for access
EXPOSE 80/tcp

# Run the Apache server
CMD ["/usr/sbin/httpd", "-f", "/etc/apache2/httpd.conf", "-D", "FOREGROUND"]


