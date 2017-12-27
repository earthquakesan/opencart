build-opencart:
	docker build -t opencart-php:7.0-apache ./docker

copy-configs:
	cp upload/config-dist.php upload/config.php
	cp upload/admin/config-dist.php upload/admin/config.php

set-permissions:
	chmod 0777 -R upload/system/storage/session/
	chmod 0777 upload/system/storage/cache/
	chmod 0777 upload/system/storage/logs/
	chmod 0777 upload/system/storage/download/
	chmod 0777 upload/system/storage/upload/
	chmod 0777 upload/system/storage/modification/
	chmod 0777 upload/image/
	chmod 0777 upload/image/cache/
	chmod 0777 upload/image/catalog/
	chmod 0777 upload/config.php
	chmod 0777 upload/admin/config.php

start:
	docker run -d -p 3306:3306 --name mysql-opencart -e MYSQL_DATABASE=opencart -e MYSQL_USER=opencart -e MYSQL_PASSWORD=opencart -e MYSQL_ROOT_PASSWORD=opencart mysql:8.0.3
	docker run -d -p 80:80 --name opencart -v $(shell pwd)/upload:/var/www/html opencart-php:7.0-apache

stop:
	docker stop mysql-opencart opencart

kill:
	docker stop mysql-opencart opencart
	docker rm mysql-opencart opencart

restart: stop start

force-restart: kill start
