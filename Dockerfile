FROM philipealmeida/opensuse-php

MAINTAINER Philipe Allan Almeida <philipeph3@gmail.com>

#Configuração do Host
RUN echo export 172.17.0.2      desenvolvimento.mds.net >> /etc/hosts

#Configuração do Vhost no apache
ADD ./config/redesuas.conf /etc/apache2/vhosts.d/redesuas.conf
ADD ./config/redesuas-ssl.conf /etc/apache2/vhosts.d/redesuas-ssl.conf

#Configuração das chaves
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl.key/phpit.key -out /etc/apache2/ssl.crt/phpit.crt -subj "/C=AT/ST=Philipe/L=Philipe/O=Security/OU=Development/CN=example.com"

#Ativa o SSL
RUN a2enmod ssl

#Restarta o apache
RUN /usr/sbin/apachectl restart

VOLUME "/srv/www/htdocs"

EXPOSE 80
EXPOSE 443

CMD /usr/sbin/apache2ctl -D FOREGROUND
