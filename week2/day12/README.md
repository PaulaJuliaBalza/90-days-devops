# Día 12: 🏗️ Aprende a trabajar a construir imágenes Docker

Hoy vamos a aprender cómo construir tus propias **imágenes Docker personalizadas** a partir de un archivo `Dockerfile`.

Una imagen es como una plantilla congelada de tu aplicación, empaquetada con todo lo que necesita para ejecutarse: sistema operativo base, dependencias, archivos, puertos, variables, y más.

___

## 🧠 ¿Qué es un Dockerfile?[](https://90daysdevops.295devops.com/semana-02/dia8#-qu%C3%A9-es-un-dockerfile "Enlace directo al 🧠 ¿Qué es un Dockerfile?")

Un **Dockerfile** es un archivo de texto que contiene instrucciones para construir una imagen Docker paso a paso.  
Cada instrucción agrega una capa a la imagen.

___

## 📁 Estructura mínima de una imagen[](https://90daysdevops.295devops.com/semana-02/dia8#-estructura-m%C3%ADnima-de-una-imagen "Enlace directo al 📁 Estructura mínima de una imagen")

1.  **Crear un nuevo directorio**:

```
mkdir simple-nginx && cd simple-nginx
```

2.  **Crear archivo HTML (`index.html`)**:

```
<h1>¡Hola desde mi imagen Docker personalizada!</h1>
```

3.  **Crear archivo `Dockerfile`**:

```
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

___

### 🧱 **Instrucciones básicas del Dockerfile**[](https://90daysdevops.295devops.com/semana-02/dia8#-instrucciones-b%C3%A1sicas-del-dockerfile "Enlace directo al -instrucciones-básicas-del-dockerfile")

| Instrucción | ¿Para qué sirve? | Ejemplo |  |  |
| --- | --- | --- | --- | --- |
| `FROM` | Define la imagen base. Siempre es la primera instrucción. | `FROM node:18-alpine` |  |  |
| `WORKDIR` | Establece el directorio de trabajo dentro del contenedor. | `WORKDIR /app` |  |  |
| `COPY` | Copia archivos del host al contenedor. | `COPY . /app` |  |  |
| `ADD` | Igual que `COPY`, pero permite descomprimir `.tar` o descargar desde URL. | `ADD archivo.tar.gz /app` |  |  |
| `RUN` | Ejecuta comandos en la construcción de la imagen. | `RUN npm install` |  |  |
| `CMD` | Define el comando por defecto al ejecutar el contenedor. | `CMD ["npm", "start"]` |  |  |
| `ENTRYPOINT` | Similar a `CMD`, pero no se sobreescribe fácilmente. Ideal para comandos fijos. | `ENTRYPOINT ["node", "index.js"]` |  |  |
| `ENV` | Define variables de entorno dentro del contenedor. | `ENV PORT=3000` |  |  |
| `EXPOSE` | Documenta el puerto que la app escucha (no abre el puerto). | `EXPOSE 8080` |  |  |
| `LABEL` | Añade metadatos a la imagen. | `LABEL maintainer="roxs@example.com"` |  |  |
| `VOLUME` | Crea un punto de montaje para persistencia. | `VOLUME /data` |  |  |
| `ARG` | Define variables disponibles solo durante el build. | `ARG VERSION=1.0` |  |  |
| `USER` | Define el usuario que ejecuta los comandos dentro del contenedor. | `USER node` |  |  |
| `HEALTHCHECK` | Define cómo Docker verifica que el contenedor está sano. | \`HEALTHCHECK CMD curl --fail [http://localhost:3000](http://localhost:3000/) |  | exit 1\` |

___

## 🛠️ Construir tu imagen Docker[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-construir-tu-imagen-docker "Enlace directo al 🛠️ Construir tu imagen Docker")

Ejecutá el siguiente comando en el mismo directorio donde está tu Dockerfile:

```
docker build -t simple-nginx:v1 .
```

-   `-t`: Define el nombre y la versión/tag de la imagen
-   `.`: Indica que el contexto de build es el directorio actual

___

## 🔍 Verificar tu imagen[](https://90daysdevops.295devops.com/semana-02/dia8#-verificar-tu-imagen "Enlace directo al 🔍 Verificar tu imagen")

-   **Listar imágenes disponibles**:
```
docker images
```
-   **Ver el historial de capas**:

```
docker history simple-nginx:v1
```

-   **Inspeccionar detalles de la imagen**:

```
docker inspect simple-nginx:v1
```

___

## 🚀 Ejecutar un contenedor desde tu imagen[](https://90daysdevops.295devops.com/semana-02/dia8#-ejecutar-un-contenedor-desde-tu-imagen "Enlace directo al 🚀 Ejecutar un contenedor desde tu imagen")

```
docker run -d --name my-nginx -p 8080:80 simple-nginx:v1
```

-   `-d`: Ejecuta en segundo plano
-   `--name`: Asigna un nombre personalizado
-   `-p 8080:80`: Mapea el puerto 80 del contenedor al 8080 local

Visitá: [http://localhost:8080](http://localhost:8080/)

___

## 🧼 Limpiar recursos[](https://90daysdevops.295devops.com/semana-02/dia8#-limpiar-recursos "Enlace directo al 🧼 Limpiar recursos")

-   **Eliminar contenedor:**
```
docker rm -f my-nginx
```
-   **Eliminar imagen:**

```
docker rmi simple-nginx:v1
```

-   **Eliminar imágenes no utilizadas:**
```
docker image prune -a
```
___

## 📚 Buenas prácticas básicas para tu Dockerfile[](https://90daysdevops.295devops.com/semana-02/dia8#-buenas-pr%C3%A1cticas-b%C3%A1sicas-para-tu-dockerfile "Enlace directo al 📚 Buenas prácticas básicas para tu Dockerfile")

-   Usá imágenes base livianas (`alpine`, `distroless`, etc.)
-   Siempre limpiá archivos temporales en `RUN`
-   Agrupá comandos para reducir capas
-   Usá `.dockerignore` para excluir archivos innecesarios

🧾 Ejemplo de `.dockerignore`:
```
.git
node_modules
*.log
```
___

## 🔧 Ejemplo: Construcción de una Imagen Docker de una Aplicación Node.js

Este ejemplo crea una imagen Docker para una app básica de Node.js que devuelve un saludo en un endpoint HTTP.

### 1\. Crea una carpeta del proyecto[](https://90daysdevops.295devops.com/semana-02/dia8#1-crea-una-carpeta-del-proyecto "Enlace directo al 1. Crea una carpeta del proyecto")

```
mkdir hello-node && cd hello-node
```

### 2\. Crea el archivo `index.js`[](https://90daysdevops.295devops.com/semana-02/dia8#2-crea-el-archivo-indexjs "Enlace directo al 2-crea-el-archivo-indexjs")

```
const http = require('http');

const PORT = process.env.PORT || 3000;

http.createServer((req, res) => {
  res.writeHead(200, { 'Content-Type': 'text/plain' });
  res.end('¡Hola desde Docker y Node.js!\n');
}).listen(PORT);

console.log(`Servidor corriendo en http://localhost:${PORT}`);
```

### 3\. Crea un `package.json`[](https://90daysdevops.295devops.com/semana-02/dia8#3-crea-un-packagejson "Enlace directo al 3-crea-un-packagejson")

```
{
  "name": "hello-node",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "node index.js"
  }
}
```

### 4\. Instala las dependencias[](https://90daysdevops.295devops.com/semana-02/dia8#4-instala-las-dependencias "Enlace directo al 4. Instala las dependencias")
```
npm install
```
### 5\. Crea el archivo `Dockerfile`[](https://90daysdevops.295devops.com/semana-02/dia8#5-crea-el-archivo-dockerfile "Enlace directo al 5-crea-el-archivo-dockerfile")

```
FROM node:18-alpine
WORKDIR /app
COPY package.json ./
COPY index.js ./
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]
```

### 6\. Construye tu imagen[](https://90daysdevops.295devops.com/semana-02/dia8#6-construye-tu-imagen "Enlace directo al 6. Construye tu imagen")

```
docker build -t hello-node-app .
```

### 7\. Ejecuta tu contenedor[](https://90daysdevops.295devops.com/semana-02/dia8#7-ejecuta-tu-contenedor "Enlace directo al 7. Ejecuta tu contenedor")

```
docker run -d --name hello-app -p 3000:3000 hello-node-app
```

📍 Navegá a: [http://localhost:3000](http://localhost:3000/)

___

## ✅ Tarea del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-tarea-del-d%C3%ADa "Enlace directo al ✅ Tarea del Día")

1.  Creá un directorio `simple-nginx`
2.  Escribí un archivo `index.html` con tu propio mensaje
3.  Creá un `Dockerfile` como el del ejemplo
4.  Construí la imagen usando `docker build`
5.  Ejecutá el contenedor y verificá que tu página aparece en `http://localhost:8080`
6.  Compartí una captura del navegador en el grupo con el mensaje de tu HTML personalizado 🚀

## 🚦 Conectando Contenedores Docker[](https://90daysdevops.295devops.com/semana-02/dia8#-conectando-contenedores-docker "Enlace directo al 🚦 Conectando Contenedores Docker")

Docker es una herramienta poderosa para desplegar aplicaciones, pero al principio puede parecer compleja. En este desafío vas a aprender cómo **conectar contenedores Docker** para crear una aplicación multi-contenedor. Empezaremos con ejemplos simples y avanzaremos hacia una aplicación más completa.

El objetivo es que experimentes cómo hacer que los contenedores se comuniquen entre sí, una habilidad fundamental para construir aplicaciones robustas con Docker.

> ⚡ **Este es un Desafío:** A diferencia de un laboratorio guiado, aquí deberás intentar resolver la tarea por tu cuenta. Si te resulta difícil, podés consultar con tus compañeros o buscar la solución. ¡Animate a intentarlo!

### ¿Qué vas a practicar?[](https://90daysdevops.295devops.com/semana-02/dia8#qu%C3%A9-vas-a-practicar "Enlace directo al ¿Qué vas a practicar?")

-   Crear y ejecutar múltiples contenedores Docker.
-   Conectar contenedores usando redes de Docker.
-   Hacer que los contenedores se comuniquen entre sí.

### ¿Por dónde empezar?[](https://90daysdevops.295devops.com/semana-02/dia8#por-d%C3%B3nde-empezar "Enlace directo al ¿Por dónde empezar?")

1.  **Lee la introducción y ejemplos del tutorial:**  
    [Docker: Connect Containers with Link](https://labex.io/tutorials/docker-connect-containers-with-link-49351#introduction)
    
2.  **Intenta replicar los ejemplos básicos de conexión entre contenedores.**
    
3.  **Desafío:**  
    Crea dos contenedores (por ejemplo, un contenedor web y uno de base de datos) y configúralos para que puedan comunicarse entre sí usando una red de Docker.
    
4.  **Comparte:**  
    Sube una captura o describe cómo lograste la comunicación entre los contenedores.
    

> 💡 **Tip:** Usá el comando `docker network` para crear redes personalizadas y conectar tus contenedores.



## 🔥 Desafío Avanzado: Variables de entorno desde Dockerfile[](https://90daysdevops.295devops.com/semana-02/dia8#-desaf%C3%ADo-avanzado-variables-de-entorno-desde-dockerfile "Enlace directo al 🔥 Desafío Avanzado: Variables de entorno desde Dockerfile")

Modificá tu Dockerfile para incluir una variable de entorno y mostrarla al arrancar:

```
FROM alpine
ENV SALUDO="¡Hola Roxs DevOps!"
CMD ["sh", "-c", "echo $SALUDO && sleep 5"]
```

-   Volvé a construir la imagen y ejecutala:

```
docker build -t saludo-roxs .
docker run --rm saludo-roxs
```





