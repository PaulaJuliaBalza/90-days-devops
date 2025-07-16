### Buenas prácticas 
- Volúmenes persistentes para datos y DB
- Healthcheck en MariaDB
- Variables de entorno separadas
- Red aislada para seguridad

### Configuración para desarrollo
- mapeo directo de wp-content para temas/plugins
- WordPress: http://localhost:8080
- phpMyAdmin: http://localhost:8081

### Despliegue
En el directorio en donde se encuentra el archivo docker-compose.yml ejecutar:
```
docker compose up -d

docker ps
CONTAINER ID   IMAGE                     COMMAND                  CREATED          STATUS                    PORTS                                   NAMES
fa2247eaf170   wordpress:php8.2-apache   "docker-entrypoint.s…"   45 seconds ago   Up 33 seconds             0.0.0.0:8080->80/tcp, :::8080->80/tcp   wp-web
13fc760d06bd   phpmyadmin:latest         "/docker-entrypoint.…"   45 seconds ago   Up 44 seconds             0.0.0.0:8081->80/tcp, :::8081->80/tcp   wp-admin
1e0fb4d6cb00   mariadb:11.3              "docker-entrypoint.s…"   45 seconds ago   Up 44 seconds (healthy)   3306/tcp                                wp-db

```
### Comandos útiles
```
# Ver logs en tiempo real
docker compose logs -f wordpress

# Acceder a MySQL CLI
docker compose exec db mysql -u wpuser -p

# Borrar todo (incluyendo datos)
docker compose down --volumes
```
### Issues y soluciones
El healtcheck de MariaDB no tiene las credenciales definidas
```
docker ps
CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS                     PORTS                                   NAMES
00d87dfb488f   phpmyadmin:latest   "/docker-entrypoint.…"   3 minutes ago   Up 3 minutes               0.0.0.0:8081->80/tcp, :::8081->80/tcp   wp-admin
2571bda9a7bc   mariadb:11.3        "docker-entrypoint.s…"   3 minutes ago   Up 3 minutes (unhealthy)   3306/tcp                                wp-db

docker logs db 
docker inspect wp-db | grep -A 20 Healthcheck

    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost", "-uwpuser", "-pwppass123"]
      interval: 10s
      timeout: 5s
      retries: 5
Se cambia el comando usado para el healthcheck:
docker exec -it wp-db bash
mysqladmin ping -h localhost -uwpuser -pwppass123
root@729be9623e18:/# mysqladmin ping -h localhost -uwpuser -pwppass123
bash: mysqladmin: command not found

root@729be9623e18:/# mariadb -uwpuser -pwppass123 -e 'SELECT 1;'
+---+
| 1 |
+---+
| 1 |
+---+

```
Fuente:
https://mariadb.org/mariadb-server-docker-official-images-healthcheck-without-mysqladmin/

### Mejoras
- Seguridad en producción
Cambiar contraseñas por defecto
Usa secrets para las credenciales:
```
secrets:
  db_password:
    file: ./secrets/db_password.txt
```
- Performance
Para alta demanda, añadir:
```
wordpress:
  deploy:
    resources:
      limits:
        cpus: '1'
        memory: 512M
```
