# wordpress-sqlite
Lightweight Wordpress on Alpine with php-fpm ondemand and SQLite instead of MySQL.

```bash
docker pull milanb/wordpress-sqlite
```
[Docker Hub milanb/wordpress-sqlite](https://hub.docker.com/r/milanb/wordpress-sqlite/)

Can be used in conjunction with [wordpress-nginx](https://github.com/milanboers/wordpress-nginx) ([Docker Hub milanb/wordpress-nginx](https://hub.docker.com/r/milanb/wordpress-nginx/)) to provide a full lightweight Wordpress solution.

Example docker-compose.yml for both:
```yaml
version: '3'
services:
    wp:
        image: milanb/wordpress-sqlite
        environment:
            - WP_HOME=https://mysite.com
            - WP_SITEURL=https://mysite.com
        volumes:
            - db:/var/www/db
            - html:/var/www/html
            - uploads:/var/www/html/wp-content/uploads
        restart: always
    http:
        image: milanb/wordpress-nginx
        links:
            - wp:wordpress
        volumes:
            - html:/var/www/html
            - uploads:/var/www/html/wp-content/uploads
        ports:
            - "8081:80"
volumes:
    db:
        external: true
    uploads:
        external: true
    html:
```
