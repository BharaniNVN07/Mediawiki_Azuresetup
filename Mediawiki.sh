#! /bin/bash
# Mediawiki Installation
cd /opt
wget -O mediawiki.tar.gz https://releases.wikimedia.org/mediawiki/1.32/mediawiki-1.32.0.tar.gz
sudo tar -zxvf mediawiki.tar.gz
sudo mkdir -p /var/www/mediawiki
sudo mv mediawiki*/* /var/www/mediawiki

chown -R www-data:www-data /var/www/mediawiki

# Configure Mediawiwki - If this gives a 404 error then working a symbolic link should solve it
sudo ln -s /var/www/mediawiki /var/www/html/mediawiki

systemctl restart nginx
