# Día 10: Gestión de contenedores de Docker 

## 🐳 Aprende a controlar y administrar contenedores de forma efectiva[](https://90daysdevops.295devops.com/semana-02/dia8#-aprende-a-controlar-y-administrar-contenedores-de-forma-efectiva "Enlace directo al 🐳 Aprende a controlar y administrar contenedores de forma efectiva")

En este día vas a dominar el **ciclo de vida de los contenedores**, ejecutar comandos dentro de ellos, copiar archivos, configurar variables de entorno y obtener información avanzada. Todo esto es esencial para tener control total de tus entornos en desarrollo, testing y producción.

___

## 🚀 Ejecutando un contenedor en segundo plano[](https://90daysdevops.295devops.com/semana-02/dia8#-ejecutando-un-contenedor-en-segundo-plano "Enlace directo al 🚀 Ejecutando un contenedor en segundo plano")

Podés ejecutar un contenedor que corra en segundo plano con `-d`:

```
docker run -d --name contenedor2 ubuntu bash -c "while true; do echo hello world; sleep 1; done"
```

### Verificar que está corriendo:[](https://90daysdevops.295devops.com/semana-02/dia8#verificar-que-est%C3%A1-corriendo "Enlace directo al Verificar que está corriendo:")
```
docker ps
```
### Ver qué está haciendo:[](https://90daysdevops.295devops.com/semana-02/dia8#ver-qu%C3%A9-est%C3%A1-haciendo "Enlace directo al Ver qué está haciendo:")
```
docker logs contenedor2
```
### Detener y eliminar el contenedor:[](https://90daysdevops.295devops.com/semana-02/dia8#detener-y-eliminar-el-contenedor "Enlace directo al Detener y eliminar el contenedor:")

```
docker stop contenedor2
docker rm contenedor2
```

Si querés borrarlo sin detenerlo primero:
```
docker rm -f contenedor2
```
___

## 🔁 Ciclo de vida de contenedores[](https://90daysdevops.295devops.com/semana-02/dia8#-ciclo-de-vida-de-contenedores "Enlace directo al 🔁 Ciclo de vida de contenedores")

Ejemplo con un contenedor que imprime la hora cada segundo:

```
docker run -d --name hora-container ubuntu bash -c 'while true; do echo $(date +"%T"); sleep 1; done'
docker logs -f hora-container
```

### En otra terminal, podés probar:[](https://90daysdevops.295devops.com/semana-02/dia8#en-otra-terminal-pod%C3%A9s-probar "Enlace directo al En otra terminal, podés probar:")

| Comando | Acción |
| --- | --- |
| `docker stop hora-container` | Detiene |
| `docker start hora-container` | Inicia |
| `docker restart hora-container` | Reinicia |
| `docker pause hora-container` | Pausa |
| `docker unpause hora-container` | Reanuda |

___

## 💬 Ejecutar comandos dentro del contenedor[](https://90daysdevops.295devops.com/semana-02/dia8#-ejecutar-comandos-dentro-del-contenedor "Enlace directo al 💬 Ejecutar comandos dentro del contenedor")

```
docker exec hora-container date
```

Crear un nuevo contenedor que guarde la hora en un archivo:

```
docker run -d --name hora-container2 ubuntu bash -c 'while true; do date +"%T" >> hora.txt; sleep 1; done'
docker exec hora-container2 ls
docker exec hora-container2 cat hora.txt
```

___

## 📂 Copiar archivos entre host y contenedor[](https://90daysdevops.295devops.com/semana-02/dia8#-copiar-archivos-entre-host-y-contenedor "Enlace directo al 📂 Copiar archivos entre host y contenedor")

### Desde host hacia contenedor:[](https://90daysdevops.295devops.com/semana-02/dia8#desde-host-hacia-contenedor "Enlace directo al Desde host hacia contenedor:")

```
echo "Curso Docker" > docker.txt
docker cp docker.txt hora-container2:/tmp
docker exec hora-container2 cat /tmp/docker.txt
```

### Desde contenedor hacia el host:[](https://90daysdevops.295devops.com/semana-02/dia8#desde-contenedor-hacia-el-host "Enlace directo al Desde contenedor hacia el host:")

```
docker cp hora-container2:hora.txt .
```

___

## 🔎 Procesos y detalles del contenedor[](https://90daysdevops.295devops.com/semana-02/dia8#-procesos-y-detalles-del-contenedor "Enlace directo al 🔎 Procesos y detalles del contenedor")

### Ver procesos en ejecución:[](https://90daysdevops.295devops.com/semana-02/dia8#ver-procesos-en-ejecuci%C3%B3n "Enlace directo al Ver procesos en ejecución:")

```
docker top hora-container2
```

### Inspeccionar contenedor (JSON detallado):[](https://90daysdevops.295devops.com/semana-02/dia8#inspeccionar-contenedor-json-detallado "Enlace directo al Inspeccionar contenedor (JSON detallado):")

```
docker inspect hora-container2
```

### Filtros útiles con `--format`:[](https://90daysdevops.295devops.com/semana-02/dia8#filtros-%C3%BAtiles-con---format "Enlace directo al filtros-útiles-con---format")

-   ID del contenedor:
    
    ```
    docker inspect --format='{{.Id}}' hora-container2
    ```
    
-   Imagen usada:
    
    ```
    docker inspect --format='{{.Config.Image}}' hora-container2
    ```
    
-   Variables de entorno:
    
    ```
    docker container inspect -f '{{range .Config.Env}}{{println .}}{{end}}' hora-container2
    ```
    
-   Comando ejecutado:
    
    ```
    docker inspect --format='{{range .Config.Cmd}}{{println .}}{{end}}' hora-container2
    ```
    
-   IP asignada:
    
    ```
    docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' hora-container2

    ```
    

___

## 🌍 Configuración de contenedores con variables de entorno[](https://90daysdevops.295devops.com/semana-02/dia8#-configuraci%C3%B3n-de-contenedores-con-variables-de-entorno "Enlace directo al 🌍 Configuración de contenedores con variables de entorno")

Para configurar valores dentro del contenedor, usamos el flag `-e`:

```
docker run -it --name prueba -e USUARIO=prueba ubuntu bash
```

Comprobamos el valor dentro del contenedor:

```
echo $USUARIO
```
___

## 🛢️ Configuración de un contenedor con la imagen mariadb[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-configuraci%C3%B3n-de-un-contenedor-con-la-imagen-mariadb "Enlace directo al 🛢️ Configuración de un contenedor con la imagen mariadb")

Algunas imágenes, como `mariadb`, requieren variables para inicializarse. Según su [documentación](https://hub.docker.com/_/mariadb), una variable obligatoria es:

```
docker run -d --name some-mariadb -e MARIADB_ROOT_PASSWORD=my-secret-pw mariadb

```

Verificamos la variable dentro del contenedor:

```
docker exec -it some-mariadb env
```

Accedemos a MariaDB desde el contenedor:

```
docker exec -it some-mariadb mariadb -u root -p


```

___

### 🌐 Accediendo a MariaDB desde el exterior[](https://90daysdevops.295devops.com/semana-02/dia8#-accediendo-a-mariadb-desde-el-exterior "Enlace directo al 🌐 Accediendo a MariaDB desde el exterior")

1.  Eliminamos el contenedor anterior:

```
docker rm -f some-mariadb
```

2.  Creamos uno nuevo exponiendo el puerto:

```
docker run -d -p 3306:3306 --name some-mariadb -e MARIADB_ROOT_PASSWORD=my-secret-pw mariadb
```

3.  Accedemos desde el host (requiere tener instalado el cliente de mariadb):

```
mysql -u root -p -h 127.0.0.1

```

___

## 🧠 Reto del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-reto-del-d%C3%ADa "Enlace directo al 🧠 Reto del Día")

1.  **Crea un contenedor personalizado** que cada 5 segundos escriba un mensaje diferente (puede ser la hora, un contador o un texto aleatorio) en un archivo llamado `mensajes.txt`.
2.  **Copia el archivo `mensajes.txt`** desde el contenedor al host y verifica su contenido.
3.  **Utiliza `docker inspect`** para obtener la IP del contenedor y el nombre de la imagen utilizada.
4.  **Comprueba los procesos activos** dentro del contenedor usando `docker top` y verifica que el proceso principal sigue ejecutándose.
5.  **Detén y elimina el contenedor de forma forzada** usando un solo comando.
6.  _(Opcional)_ Automatiza los pasos anteriores con un pequeño script bash.

___
## Reto extra: Variables de Entorno
1.  **Ejecuta un contenedor de Alpine** pasándole dos variables de entorno: `APP_ENV=development` y `APP_VERSION=1.0.0`. Haz que el contenedor imprima ambas variables.

```
docker run --rm -e APP_ENV=development -e APP_VERSION=1.0.0 alpine sh -c 'echo Entorno: $APP_ENV, Versión: $APP_VERSION'

```

2.  **Crea un contenedor de MariaDB** que utilice variables de entorno para definir el usuario, contraseña y base de datos inicial. Verifica que las variables estén correctamente configuradas dentro del contenedor.






