    #!/bin/ash
    cd /var/www/wordpress

    cp wp-config-sample.php wp-config.php

    sed -i "s/database_name_here/${MYSQL_NAME}/" wp-config.php
    sed -i "s/username_here/${MYSQL_USER}/" wp-config.php
    sed -i "s/password_here/${MYSQL_USER_PASSWORD}/" wp-config.php
    sed -i "s/localhost/${WP_DB_HOST}/" wp-config.php

    wp core install --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --allow-root

    php-fpm81 -F
