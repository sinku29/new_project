FROM ubuntu:latest
RUN apt install apache2 && zip unzip -y
ADD https://www.tooplate.com/zip-templates/2134_gotto_job.zip /var/www/html
WORKDIR /var/www/html/
RUN unzip 2134_gotto_job.zip
RUN cp -rvf 2134_gotto_job/* .
RUN rm -rf 2134_gotto_job 2134_gotto_job.zip
CMD ["usr/sbin/apache2", "-D", "FOREGROUND"]
EXPOSE 80