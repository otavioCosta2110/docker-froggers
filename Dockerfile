FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update -y
RUN apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install apache2 mysql-server php php-mysql git -y
RUN mkdir /froggers
RUN git clone 'https://github.com/julioSCassol/froggers' /froggers
RUN chmod -R 755 /froggers
RUN sed -i 's|/var/www/html|/froggers|g' /etc/apache2/apache2.conf
RUN sed -i 's|/var/www/html|/froggers|g' /etc/apache2/sites-available/000-default.conf
RUN echo '<Directory /froggers>\n\tOptions Indexes FollowSymLinks\n\tAllowOverride None\n\tRequire all granted\n</Directory>' >> /etc/apache2/sites-available/000-default.conf
EXPOSE 80
EXPOSE 3306
RUN echo '<?php phpinfo(); ?>' > /var/www/html/index.php
CMD ["sh", "-c", "service apache2 start; service mysql start; /bin/sh"]


# sed -i 's|/var/www|/froggers|g' /etc/apache2/sites-available/000-default.conf
# service apache2 restart