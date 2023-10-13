FROM ubuntu:latest
RUN apt-get update && apt-get install -y apache2
COPY job /var/www/html
WORKDIR /var/www/html/
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80