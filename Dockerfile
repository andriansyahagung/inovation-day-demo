from phpmyadmin/phpmyadmin:5.0.2

RUN mkdir /var/www/html/project
COPY . /var/www/html/project