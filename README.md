# Wordpress

[![CircleCI](https://circleci.com/gh/Jarzamendia/wordpress.svg?style=svg)](https://circleci.com/gh/Jarzamendia/wordpress)
[![](https://images.microbadger.com/badges/version/jarzamendia/wordpress-nginx.svg)](https://microbadger.com/images/jarzamendia/wordpress-nginx "Get your own version badge on microbadger.com")

Docker Hub: https://hub.docker.com/r/jarzamendia/wordpress-nginx

Imagem com PHP-FPM e Nginx usada para publicar o Wordpress.

## Environment Variables

### MAX_PHP_PROCESS

A variável MAX_PHP_PROCESS é usada para definir o valor de pm.max_children. O valor padrão é 50.

Quanto maior o valor desta variável, mais memória o container usará em momentos de alto acesso. Porém mais acessos simultâneos ele aguenta.


### NGINX_PROCESS

A variável NGINX_PROCESS é usada para definir o valor de worker_processes 1. O valor padrão é 1. O ideal é 1 por CPU.

É importante lembrar que caso você utiliza limites de CPU, o valor de NGINX_PROCESS deve segui-lo.

## Modo de Uso

```shell
docker run -it -p 80:80 -v /path/to/www:/srv/www \ 
                        -e MAX_PHP_PROCESS=25 \
                        -e NGINX_PROCESS=1 \
                        --cpus="1.0" \
                        --memory="300m" \
                        jarzamendia/wordpress-nginx:latest
```

A pasta com o conteúdo do Wordpress deve ter as seguintes permissões: nobody:nobody (65534:65534).


## Criando instalação do zero

Este container, diferente do oficial do Wordpress não configura ou cria uma nova instalação do Wordpress. Para isto, podemos usar o WP CLI. Segue um exemplo:

### Iniciar o container wordpress:cli

$ docker run -it --entrypoint /bin/sh --workdir /srv/www -v wp_dir:/srv/www wordpress:cli

Ex.: docker run -it --entrypoint /bin/sh --workdir /srv/www  -v C:/wp:/srv/www wordpress:cli

### Fazer download dos arquivos do Wordpress

$ wp core download --locale=pt_BR

### Criando o arquivo wp-config.php

$ wp core config --dbhost=DatabaseIP --dbname=wordpress --dbuser=db_user --dbpass=db_password

Ex.: wp core config --dbhost=10.0.0.107 --dbname=wordpress --dbuser=root --dbpass=P@ssw0rd

### Instalando o Wordpress

$ wp core install --url=SITE_URL --title="Your Blog Title" --admin_name=wordpress_admin --admin_password=ADMIN_PASSWORD --admin_email=you@example.com --skip-email

Ex.: wp core install --url=localhost --title="Your Blog Title" --admin_name=wordpress_admin --admin_password=P@ssw0rd --admin_email=you@example.com --skip-email