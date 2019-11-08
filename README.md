# Wordpress

[![CircleCI](https://circleci.com/gh/Jarzamendia/wordpress.svg?style=svg)](https://circleci.com/gh/Jarzamendia/wordpress)
[![](https://images.microbadger.com/badges/version/jarzamendia/wordpress-nginx.svg)](https://microbadger.com/images/jarzamendia/wordpress-nginx "Get your own version badge on microbadger.com")

Docker Hub: https://hub.docker.com/r/jarzamendia/wordpress-nginx

Imagem com PHP-FPM e Nginx usada para publicar o Wordpress.

## Environment Variables

### MAX_PHP_PROCESS

A variável MAX_PHP_PROCESS é usada para definir o valor de pm.max_children. O valor padrão é 50.

Quanto maior o valor desta variável, mais memoria o container usará em momentos de alto acesso. Porém mais acessos simultâneos ele aguentará.

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