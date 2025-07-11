# Día 11: Redes y volúmenes en Docker

## 🕸️ Aprende a conectar contenedores entre sí y gestionar datos persistentes[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-aprende-a-conectar-contenedores-entre-s%C3%AD-y-gestionar-datos-persistentes "Enlace directo al 🕸️ Aprende a conectar contenedores entre sí y gestionar datos persistentes")



Hoy exploramos cómo **conectar contenedores** entre sí con redes personalizadas y cómo **persistir datos** usando volúmenes, una parte esencial para aplicaciones reales que requieren bases de datos, almacenamiento de logs o configuración compartida.

___

## 🌐 Tipos de redes en Docker[](https://90daysdevops.295devops.com/semana-02/dia8#-tipos-de-redes-en-docker "Enlace directo al 🌐 Tipos de redes en Docker")

Docker soporta distintos tipos de redes. Cada una se usa para distintos casos de uso:

| Tipo | Descripción |
| --- | --- |
| **bridge** | Red por defecto para contenedores en una misma máquina |
| **host** | El contenedor comparte la red del host (sin aislamiento de red) |
| **none** | Sin red. El contenedor no se conecta a ninguna red |
| **overlay** | Usado con Docker Swarm para comunicar contenedores entre múltiples hosts |
| **macvlan** | Asigna una IP directamente desde la red del host. Útil para apps legacy |

### 🔍 Ver todas las redes disponibles:[](https://90daysdevops.295devops.com/semana-02/dia8#-ver-todas-las-redes-disponibles "Enlace directo al 🔍 Ver todas las redes disponibles:")
```
docker network ls
```
___

## 🔌 Crear y usar una red personalizada[](https://90daysdevops.295devops.com/semana-02/dia8#-crear-y-usar-una-red-personalizada "Enlace directo al 🔌 Crear y usar una red personalizada")

```
docker network create mi-red
docker run -d --name backend --network mi-red alpine sleep 3600
docker run -it --rm --network mi-red alpine ping backend
```

✅ Los contenedores se comunican por nombre gracias al DNS interno de Docker.

___

### 🔧 Inspeccionar y eliminar redes[](https://90daysdevops.295devops.com/semana-02/dia8#-inspeccionar-y-eliminar-redes "Enlace directo al 🔧 Inspeccionar y eliminar redes")

```
docker network inspect mi-red
docker network rm mi-red
```

> ⚠️ No se puede eliminar una red si hay contenedores activos conectados.

___

## 💾 Tipos de volúmenes[](https://90daysdevops.295devops.com/semana-02/dia8#-tipos-de-vol%C3%BAmenes "Enlace directo al 💾 Tipos de volúmenes")

Docker permite dos formas principales de persistencia:

| Tipo | ¿Dónde se guarda? | Uso recomendado |
| --- | --- | --- |
| **volúmenes gestionados** (`docker volume`) | En la ruta `/var/lib/docker/volumes` del host | Compartir datos entre contenedores |
| **bind mounts** | En cualquier ruta del host (ej: `./datos`) | Desarrollo local, sincronización en vivo |
| **tmpfs** | En memoria RAM (temporal) | Apps sensibles que no necesitan persistencia |

___

## 📦 Crear y usar un volumen[](https://90daysdevops.295devops.com/semana-02/dia8#-crear-y-usar-un-volumen "Enlace directo al 📦 Crear y usar un volumen")

```
docker volume create datos-app
docker run -d --name contenedor-volumen -v datos-app:/datos alpine sh -c "while true; do date >> /datos/fechas.log; sleep 5; done"
docker exec contenedor-volumen cat /datos/fechas.log
```

### 📋 Ver volúmenes disponibles:[](https://90daysdevops.295devops.com/semana-02/dia8#-ver-vol%C3%BAmenes-disponibles "Enlace directo al 📋 Ver volúmenes disponibles:")
```
docker volume ls
```
### 🧽 Eliminar un volumen (si no está en uso):[](https://90daysdevops.295devops.com/semana-02/dia8#-eliminar-un-volumen-si-no-est%C3%A1-en-uso "Enlace directo al 🧽 Eliminar un volumen (si no está en uso):")

```
docker volume rm datos-app
```

___

## 🗂️ Bind Mounts (montar directorios del host)[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-bind-mounts-montar-directorios-del-host "Enlace directo al 🗂️ Bind Mounts (montar directorios del host)")

```
mkdir datos-local
docker run -it --name con-mount -v $(pwd)/datos-local:/datos alpine sh
```

✅ Todo lo que guardes en `/datos` del contenedor aparece en tu carpeta local `datos-local`.

___

## 🔁 Comandos útiles de redes y volúmenes[](https://90daysdevops.295devops.com/semana-02/dia8#-comandos-%C3%BAtiles-de-redes-y-vol%C3%BAmenes "Enlace directo al 🔁 Comandos útiles de redes y volúmenes")

### Redes[](https://90daysdevops.295devops.com/semana-02/dia8#redes "Enlace directo al Redes")

```
docker network create <nombre>
docker network ls
docker network inspect <nombre>
docker network rm <nombre>
docker network connect <red> <contenedor>
docker network disconnect <red> <contenedor>
```

### Volúmenes[](https://90daysdevops.295devops.com/semana-02/dia8#vol%C3%BAmenes "Enlace directo al Volúmenes")

```
docker volume create <nombre>
docker volume ls
docker volume inspect <nombre>
docker volume rm <nombre>
```

## 🧪 Ejemplo: MySQL con Docker[](https://90daysdevops.295devops.com/semana-02/dia8#-ejemplo-mysql-con-docker "Enlace directo al 🧪 Ejemplo: MySQL con Docker")

Este ejemplo muestra cómo configurar y gestionar un contenedor de MySQL y persistir sus datos.

### 1\. Crear el contenedor con volumen persistente:[](https://90daysdevops.295devops.com/semana-02/dia8#1-crear-el-contenedor-con-volumen-persistente "Enlace directo al 1. Crear el contenedor con volumen persistente:")

```
docker run -d --name mysql-container \
  -e MYSQL_ROOT_PASSWORD=my-data-pass \
  -v /data/mysql-data:/var/lib/mysql \
  mysql
```

### 2\. Acceder al contenedor:[](https://90daysdevops.295devops.com/semana-02/dia8#2-acceder-al-contenedor "Enlace directo al 2. Acceder al contenedor:")

```
docker exec -it mysql-container bash
mysql -u root -p
```

(Contraseña: `my-data-pass`)

### 3\. Ejecutar un script SQL (dentro del contenedor):[](https://90daysdevops.295devops.com/semana-02/dia8#3-ejecutar-un-script-sql-dentro-del-contenedor "Enlace directo al 3. Ejecutar un script SQL (dentro del contenedor):")

```
USE base_de_datos;
SOURCE /ruta/al/archivo/data.sql;
```

### 4\. Detener y eliminar el contenedor:[](https://90daysdevops.295devops.com/semana-02/dia8#4-detener-y-eliminar-el-contenedor "Enlace directo al 4. Detener y eliminar el contenedor:")

```
docker stop mysql-container
docker rm mysql-container
```

### 5\. Reiniciarlo y verificar que los datos persisten:[](https://90daysdevops.295devops.com/semana-02/dia8#5-reiniciarlo-y-verificar-que-los-datos-persisten "Enlace directo al 5. Reiniciarlo y verificar que los datos persisten:")

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
```

___

## 🧠 Reto del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-reto-del-d%C3%ADa "Enlace directo al 🧠 Reto del Día")

🧪 **Conecta y persiste**

1.  Crear una red personalizada `miapp-net`.
2.  Ejecutar dos contenedores `api` y `db` en esa red.
3.  Desde `api`, hacé ping a `db` para verificar conectividad.
4.  Crear un volumen `vol-db` y montarlo en `/datos` dentro del contenedor `db`.
5.  Desde `db`, escribí un archivo en `/datos/info.txt`.
6.  Eliminá el contenedor `db`, volvé a crearlo, y comprobá si el archivo sigue existiendo.

___

## 🧪 Reto Adicional: MongoDB + Mongo Express[](https://90daysdevops.295devops.com/semana-02/dia8#-reto-adicional-mongodb--mongo-express "Enlace directo al 🧪 Reto Adicional: MongoDB + Mongo Express")

🎯 **Objetivo**: Crear un entorno con dos contenedores — MongoDB y Mongo Express — y conectarlos con Docker.

### Instrucciones:[](https://90daysdevops.295devops.com/semana-02/dia8#instrucciones "Enlace directo al Instrucciones:")

1.  Crear contenedor de MongoDB:

```
docker run -d --name mongo \
  -e MONGO_INITDB_ROOT_USERNAME=admin \
  -e MONGO_INITDB_ROOT_PASSWORD=secret \
  --network miapp-net \
  mongo
```

2.  Crear contenedor de Mongo Express:

```
docker run -d --name mongo-express \
  -e ME_CONFIG_MONGODB_ADMINUSERNAME=admin \
  -e ME_CONFIG_MONGODB_ADMINPASSWORD=secret \
  -e ME_CONFIG_MONGODB_SERVER=mongo \
  -p 8081:8081 \
  --network miapp-net \
  mongo-express
```

3.  Acceder a la interfaz web en: 👉 [http://localhost:8081](http://localhost:8081/)
    
4.  Crear la base de datos `Library` y la colección `Books`.
    
5.  Importar datos (`books.json`):
    

```
[
  { "title": "Docker in Action, Second Edition", "author": "Jeff Nickoloff and Stephen Kuenzli" },
  { "title": "Kubernetes in Action, Second Edition", "author": "Marko Lukša" }
]
```

📂 Colocá este archivo en tu máquina y usá la interfaz de Mongo Express para cargarlo.

> 🔗 Documentación Mongo Express: [https://hub.docker.com/\_/mongo-express](https://hub.docker.com/_/mongo-express)

___

## 📚 Recursos complementarios[](https://90daysdevops.295devops.com/semana-02/dia8#-recursos-complementarios "Enlace directo al 📚 Recursos complementarios")

-   📘 [Documentación oficial sobre redes Docker](https://docs.docker.com/network/)
-   📘 [Documentación sobre volúmenes Docker](https://docs.docker.com/storage/volumes/)
-   🛠️ [Play with Docker para practicar online](https://labs.play-with-docker.com/)



