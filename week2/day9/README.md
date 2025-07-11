# Día 9: Construye, ejecuta y entiende tu primer contenedor

## 🧠 ¿Qué es Docker y por qué usar contenedores?[](https://90daysdevops.295devops.com/semana-02/dia8#-qu%C3%A9-es-docker-y-por-qu%C3%A9-usar-contenedores "Enlace directo al 🧠 ¿Qué es Docker y por qué usar contenedores?")

**Docker** es una plataforma que utiliza **contenedores** para desarrollar, enviar y ejecutar aplicaciones de forma consistente, sin importar dónde se ejecuten.

Un contenedor empaqueta **todo lo que una aplicación necesita**: código, dependencias, librerías, configuraciones. Es liviano, portátil y se puede mover entre entornos con total facilidad.

### ✅ Ventajas de los contenedores Docker:[](https://90daysdevops.295devops.com/semana-02/dia8#-ventajas-de-los-contenedores-docker "Enlace directo al ✅ Ventajas de los contenedores Docker:")

-   **Portabilidad**: Ejecutá tu app donde quieras, sin "funciona en mi máquina".
-   **Aislamiento**: Cada app corre de forma independiente.
-   **Eficiencia**: Usa menos recursos que las máquinas virtuales tradicionales.

___

## 🛠️ Primeros pasos: Verificá tu instalación de Docker[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-primeros-pasos-verific%C3%A1-tu-instalaci%C3%B3n-de-docker "Enlace directo al 🛠️ Primeros pasos: Verificá tu instalación de Docker")

1.  Asegurate de tener Docker instalado.  
    🔗 [Guía para instalar Docker sin gastar un peso](https://blog.295devops.com/crea-tu-laboratorio-devops-local-sin-gastar-un-peso)
    
2.  Verificá la instalación con este comando:
    ```
    docker --version
    ```

___

### Paso 1: Descargar una imagen[](https://90daysdevops.295devops.com/semana-02/dia8#paso-1-descargar-una-imagen "Enlace directo al Paso 1: Descargar una imagen")

Las **imágenes** son las plantillas base que usamos para crear contenedores.

Descargá la imagen oficial `hello-world`:
 ```
 docker pull hello-world
 ```
### Paso 2: Ejecutar tu primer contenedor[](https://90daysdevops.295devops.com/semana-02/dia8#paso-2-ejecutar-tu-primer-contenedor "Enlace directo al Paso 2: Ejecutar tu primer contenedor")
 ```
 docker run hello-world
 ```
✅ ¿Qué pasa aquí?

-   **Docker** descarga la imagen (si no la tenés localmente).
-   Crea un nuevo contenedor basado en esa imagen.
-   Ejecuta el contenido y te da un mensaje de confirmación si todo funciona.

___

## 🌐 Probá algo más real: Servidor web con NGINX[](https://90daysdevops.295devops.com/semana-02/dia8#-prob%C3%A1-algo-m%C3%A1s-real-servidor-web-con-nginx "Enlace directo al 🌐 Probá algo más real: Servidor web con NGINX")

### 1\. Descargá la imagen:[](https://90daysdevops.295devops.com/semana-02/dia8#1-descarg%C3%A1-la-imagen "Enlace directo al 1. Descargá la imagen:")
```
docker pull nginx
```
### 2\. Ejecutá el contenedor en background:[](https://90daysdevops.295devops.com/semana-02/dia8#2-ejecut%C3%A1-el-contenedor-en-background "Enlace directo al 2. Ejecutá el contenedor en background:")

```
docker run -d -p 8080:80 --name web-nginx nginx
```

-   `-d`: Modo desatendido (en segundo plano).
-   `-p 8080:80`: Expone el puerto **80 del contenedor** como **8080 en tu máquina**.
-   `--name`: Le da un nombre personalizado al contenedor.

### 3\. Verificá que funcione[](https://90daysdevops.295devops.com/semana-02/dia8#3-verific%C3%A1-que-funcione "Enlace directo al 3. Verificá que funcione")

Abrí tu navegador y entrá en [http://localhost:8080](http://localhost:8080/) 🚀 ¡Deberías ver la página por defecto de NGINX!

___

## 🔄 Ciclo de vida del contenedor[](https://90daysdevops.295devops.com/semana-02/dia8#-ciclo-de-vida-del-contenedor "Enlace directo al 🔄 Ciclo de vida del contenedor")

| Estado | Qué significa |
| --- | --- |
| **created** | El contenedor fue creado |
| **running** | Está ejecutándose activamente |
| **paused** | Está suspendido |
| **exited** | Finalizó su ejecución |

___

## 🧰 Comandos esenciales para gestión de contenedores[](https://90daysdevops.295devops.com/semana-02/dia8#-comandos-esenciales-para-gesti%C3%B3n-de-contenedores "Enlace directo al 🧰 Comandos esenciales para gestión de contenedores")

### 📋 Ver contenedores en ejecución:[](https://90daysdevops.295devops.com/semana-02/dia8#-ver-contenedores-en-ejecuci%C3%B3n "Enlace directo al 📋 Ver contenedores en ejecución:")

```
docker ps
```
### 📋 Ver todos (activos e inactivos):[](https://90daysdevops.295devops.com/semana-02/dia8#-ver-todos-activos-e-inactivos "Enlace directo al 📋 Ver todos (activos e inactivos):")

```
docker ps -a
```
### ⛔ Detener un contenedor:[](https://90daysdevops.295devops.com/semana-02/dia8#-detener-un-contenedor "Enlace directo al ⛔ Detener un contenedor:")
```
docker stop web-nginx
```
### 🗑️ Eliminar un contenedor:[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-eliminar-un-contenedor "Enlace directo al 🗑️ Eliminar un contenedor:")
```
docker rm web-nginx
```
### 🧽 Eliminar todos los contenedores detenidos:[](https://90daysdevops.295devops.com/semana-02/dia8#-eliminar-todos-los-contenedores-detenidos "Enlace directo al 🧽 Eliminar todos los contenedores detenidos:")
```
docker container prune
```
___

## 🧪 Contenedores interactivos[](https://90daysdevops.295devops.com/semana-02/dia8#-contenedores-interactivos "Enlace directo al 🧪 Contenedores interactivos")

Podés correr un contenedor tipo Ubuntu y explorar desde dentro:

```
docker run -it --name contenedor1 ubuntu bash
```

-   `-it`: Te permite interactuar como si fuera una terminal.
-   `--name`: Le asignás un nombre.
-   `ubuntu`: Imagen base.
-   `bash`: Ejecutás la shell bash.

Para salir, escribí `exit`.

🔁 Para volver a entrar después de salir:

```
docker start contenedor1
docker attach contenedor1
```

O ejecutar un comando directo:

```
docker exec contenedor1 ls -al
```

___

## 🔍 Inspeccionar un contenedor[](https://90daysdevops.295devops.com/semana-02/dia8#-inspeccionar-un-contenedor "Enlace directo al 🔍 Inspeccionar un contenedor")

```
docker inspect contenedor1
```

Te devuelve información detallada en formato JSON:

-   ID
-   Red y puertos
-   Entrypoint
-   Variables de entorno
-   Configuración de volúmenes

___

## ✅ Tarea del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-tarea-del-d%C3%ADa "Enlace directo al ✅ Tarea del Día")

1.  Ejecutá tu primer contenedor con `hello-world`.
2.  Probá NGINX en `localhost:8080`.
3.  Usá `docker ps`, `stop`, `rm`, `exec`, `inspect`.
4.  Explorá un contenedor interactivo con `ubuntu`.
5.  Compartí una captura de tu navegador con NGINX corriendo o terminal con `hello-world` OK en el grupo 💬.

🔁 **Tarea extra: Explorá el historial de imágenes**
```
docker history nginx
```
📌 Esto te va a mostrar cómo se construyó esa imagen capa por capa.

___

### 🧪 Objetivo[](https://90daysdevops.295devops.com/semana-02/dia8#-objetivo "Enlace directo al 🧪 Objetivo")

Crear un contenedor Docker con **NGINX** que sirva una web estática personalizada desde una carpeta externa, accesible en: 📍 `http://localhost:9999`

___
## Tarea del día: Tu primer sitio web en un contenedor
### 📋 Instrucciones paso a paso[](https://90daysdevops.295devops.com/semana-02/dia8#-instrucciones-paso-a-paso "Enlace directo al 📋 Instrucciones paso a paso")

1.  **Correr un contenedor llamado `bootcamp-web`**:

```
docker run -d --name bootcamp-web -p 9999:80 nginx
```

2.  **Clonar el repositorio con la web**:

```
git clone -b devops-simple-web https://github.com/roxsross/devops-static-web.git
```

3.  **Copiar el contenido al contenedor**:

```
docker cp devops-static-web/bootcamp-web/. bootcamp-web:/usr/share/nginx/html/
```

4.  **Verificar que los archivos estén copiados**:

```
docker exec bootcamp-web ls /usr/share/nginx/html
```

5.  **Acceder al sitio en tu navegador**:

Abrí: [http://localhost:9999](http://localhost:9999/)

___

### ✅ Resultado Esperado[](https://90daysdevops.295devops.com/semana-02/dia8#-resultado-esperado "Enlace directo al ✅ Resultado Esperado")

Deberías ver en pantalla una web estática servida por tu contenedor `bootcamp-web` usando NGINX.

![](https://bootcamp.295devops.com/assets/images/ses1-ejer2-fca816fd2465864500194c00360a1fb1.png)

🎉 ¡Felicitaciones! Estás dominando los contenedores.


_

## 📚 Recursos recomendados[](https://90daysdevops.295devops.com/semana-02/dia8#-recursos-recomendados "Enlace directo al 📚 Recursos recomendados")

-   🧪 [Play with Docker](https://labs.play-with-docker.com/)
-   📘 [Cheatsheet de Docker](https://dockerlabs.collabnix.com/docker/cheatsheet/)
-   📘 [Documentación oficial](https://docs.docker.com/get-started/)




