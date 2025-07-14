## 🧪 Ejemplo: MySQL con Docker

Este ejemplo muestra cómo configurar y gestionar un contenedor de MySQL y persistir sus datos.

Localmente en /data/mysql-data creo un archivo data.sql:
```
CREATE DATABASE IF NOT EXISTS base_de_datos;
USE base_de_datos;

CREATE TABLE IF NOT EXISTS usuarios (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100),
  email VARCHAR(100)
);

INSERT INTO usuarios (nombre, email) VALUES
('Ana López', 'ana@example.com'),
('Juan Pérez', 'juan@example.com'),
('María Gómez', 'maria@example.com');
```

### 1\. Crear el contenedor con volumen persistente:

```
docker run -d --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=my-data-pass \
  -v /data/mysql-data:/var/lib/mysql \
  mysql
```
```
administrator@ASC:~$ docker ps 
CONTAINER ID   IMAGE     COMMAND                  CREATED              STATUS              PORTS                 NAMES
ff6e07042b0e   mysql     "docker-entrypoint.s…"   About a minute ago   Up About a minute   3306/tcp, 33060/tcp   mysql-container
```
### 2\. Acceder al contenedor:

```
docker exec -it mysql-container bash
mysql -u root -p
```
(Contraseña: `my-data-pass`)

### 3\. Ejecutar un script SQL (dentro del contenedor):

```
SOURCE /var/lib/mysql/data.sql;

mysql> SOURCE /var/lib/mysql/data.sql;
Query OK, 1 row affected (0.057 sec)

Database changed
Query OK, 0 rows affected (0.029 sec)

Query OK, 3 rows affected (0.015 sec)
Records: 3  Duplicates: 0  Warnings: 0

```

### 4\. Detener y eliminar el contenedor:

```
docker stop mysql-container
docker rm mysql-container
```

### 5\. Reiniciarlo y verificar que los datos persisten:

```
docker run -d --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=my-data-pass \
  -v /data/mysql-data:/var/lib/mysql \
  mysql
```

```
docker exec -it mysql-container bash
mysql -u root -p
USE base_de_datos;
SELECT * FROM usuarios;

mysql> USE base_de_datos;
Database changed
mysql> SELECT * FROM usuarios;
+----+---------------+-------------------+
| id | nombre        | email             |
+----+---------------+-------------------+
|  1 | Ana López    | ana@example.com   |
|  2 | Juan Pérez   | juan@example.com  |
|  3 | María Gómez | maria@example.com |
+----+---------------+-------------------+
3 rows in set (0.001 sec)
```