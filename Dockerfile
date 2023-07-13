FROM ubuntu:latest AS BUILD_IMAGE
RUN apt update -y
RUN apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install apache2 mysql-server php -y
EXPOSE 80
EXPOSE 3306
RUN echo '<?php echo "Hello World"; ?>' > /var/www/html/index.php
CMD ["sh", "-c", "service apache2 start; service mysql.service start; /bin/sh"]
