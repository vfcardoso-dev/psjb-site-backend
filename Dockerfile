FROM wordpress:5.8
LABEL maintainer "Vinícius Cardoso (vfcardoso3@gmail.com)"

USER root

RUN apt update
RUN apt install unzip 

USER www-data

# Configuring MU Plugins
RUN mkdir /var/www/html/wp-content/plugins/mu-plugins

# Including windows azure storage plugin
RUN curl https://downloads.wordpress.org/plugin/windows-azure-storage.4.3.2.zip -o windows-azure-storage.4.3.2.zip -s
RUN unzip windows-azure-storage.4.3.2.zip -d /var/www/html/wp-content/plugins/mu-plugins

RUN echo "<?php require WPMU_PLUGIN_DIR . '/windows-azure-storage/windows-azure-storage.php';" \
            > /var/www/html/wp-content/plugins/mu-plugins/windows-azure-storage-loader.php

RUN chown -R www-data:www-data /var/www/html

# docker run -p 8181:80 -it -d --name psjb-site-backend --network innercircle `
#     -e WORDPRESS_DB_HOST="mariadb:3306" `
#     -e WORDPRESS_DB_PASSWORD="s3cr3t" `
#     -e WORDPRESS_DB_USER="root" `
#     -e WORDPRESS_DB_NAME="wordpress" `
#     -e WORDPRESS_DEBUG="true" `
#     -e WORDPRESS_DEBUG_LOG="true" `
#     -e WORDPRESS_CONFIG_EXTRA=" `
#         define('WPMU_PLUGIN_DIR', '/var/www/html/wp-content/plugins/mu-plugins'); `
#         define('WPMU_PLUGIN_URL', '/var/www/html/wp-content/plugins/mu-plugins'); `
#         define('MICROSOFT_AZURE_ACCOUNT_NAME', ''); `
#         define('MICROSOFT_AZURE_ACCOUNT_KEY', ''); `
#         define('MICROSOFT_AZURE_CONTAINER', ''); `
#         define('MICROSOFT_AZURE_USE_FOR_DEFAULT_UPLOAD', true);" `
#     -v psjb-wp-data:/var/www/html `
#     vfcardoso/psjb-site-backend