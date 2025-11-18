# Laravel

### Script
```bash
set -e  # Exit on any error

apt update
apt install git curl -y # rsync

apt install -y apache2 php php-bcmath php-curl php-json php-mbstring php-mysql php-tokenizer php-xml php-zip php-intl php-pdo php-fileinfo php-gd
php -v # PHP version
php -m # PHP modules
dpkg -l | grep php- # PHP packages debian;  dnf list installed | grep php-

echo "Starting to install composer"
curl -sS https://getcomposer.org/installer -o composer-setup.php
php composer-setup.php
mv composer.phar /usr/local/bin/composer
rm composer-setup.php

echo "Setup user and DocumentRoot"
usermod -a -G www-data my_user
# groups my_user
mkdir -p /storage/www
chown -R my_user:www-data /storage/www
sed -i 's#DocumentRoot /var/www/html#DocumentRoot /storage/www#g' /etc/apache2/sites-available/000-default.conf

#/patrón_inicio/,/patrón_final/
sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/c\
<Directory /storage/www/>\
	Options Indexes FollowSymLinks\
	AllowOverride All\
	Require all granted\
</Directory>' /etc/apache2/apache2.conf

apachectl configtest
a2enmod rewrite
systemctl restart apache2


apt install -y mariadb-server
# mariadb-secure-installation # useless

# CREATE DATABASE MY_DB CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
# GRANT SELECT, INSERT, UPDATE, CREATE, REFERENCES, INDEX ON MY_DB.* TO `MY_USER`@`localhost`
# GRANT DELETE ON MY_DB.password_resets TO 'MY_USER'@'localhost';  # After migrating laravel dbs
# GRANT DELETE ON MY_DB.sessions TO 'MY_USER'@'localhost';  # After migrating laravel dbs
# FLUSH PRIVILEGES;
# SHOW GRANTS FOR 'MY_USER'@'localhost';

# rsync -avz --partial --info=progress2 --exclude vendor  user@server:/path/to/laravel/ project/

curl -fsSL https://deb.nodesource.com/setup_24.x | bash -
apt install -y nodejs
```


### Permissions fro laravel projects
```bash
chown -R www-data:www-data /path/to/your/laravel/root/directory
usermod -a -G www-data my_user

cd LARAVEL_PROJECT
chown -R my_user:www-data . # As root, then normal user
find . -type f -exec chmod 644 {} \;
find . -type d -exec chmod 755 {} \;

chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache
```

#### Change files (manual)
```sh
# Update /etc/apache2/apache2.conf
<Directory /var/www/>
	Options Indexes FollowSymLinks
	AllowOverride None
	Require all granted
</Directory>
# with 
<Directory /storage/www/>
	Options Indexes FollowSymLinks
	AllowOverride All
	Require all granted
</Directory>

# Update /etc/apache2/sites-available/000-default.conf
DocumentRoot /var/www/html
# with
DocumentRoot /storage/www
```



