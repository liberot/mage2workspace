#!/bin/bash

echo "setup.sh"

echo "about to execute composer wait.."

/usr/bin/php -d memory_limit=-1 ./composer.phar upgrade 
/usr/bin/php -d memory_limit=-1 ./composer.phar install

echo "about to setup mage2 wait..."

/usr/bin/php -d memory_limit=-1 ./bin/magento setup:install
/usr/bin/php -d memory_limit=-1 ./bin/magento setup:upgrade
/usr/bin/php -d memory_limit=-1 ./bin/magento setup:di:compile
/usr/bin/php -d memory_limit=-1 ./bin/magento setup:static-content:deploy -f
/usr/bin/php -d memory_limit=-1 ./bin/magento indexer:reindex

echo "about to start server.. now diss is..."
/usr/bin/php -d memory_limit=-1 -S 127.0.0.1:80 -t ./pub ./phpserver/router.php

