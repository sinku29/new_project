FROM ubuntu:latest
RUN apt-get update && apt-get install -y apache2
COPY 2134_gotto_job /var/www/html
WORKDIR /var/www/html/
CMD ["apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80