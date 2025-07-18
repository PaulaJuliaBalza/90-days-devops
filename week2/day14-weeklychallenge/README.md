# 🧪 Día 14: Desafío Final - Semana Docker y Compose[](https://90daysdevops.295devops.com/semana-02/dia8#-d%C3%ADa-14-desaf%C3%ADo-final---semana-docker-y-compose "Enlace directo al 🧪 Día 14: Desafío Final - Semana Docker y Compose")

Durante esta semana aprendiste a construir imágenes, usar `Dockerfile`, y manejar múltiples contenedores con **Docker Compose**.  


___

## 🎯 Objetivo del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-objetivo-del-d%C3%ADa "Enlace directo al 🎯 Objetivo del Día")

**Dockerizar por completo la aplicación `roxs-voting-app` usando Docker Compose.**

![](https://90daysdevops.295devops.com/assets/images/2-d01bbe1a234cac3cb43291db031c49bc.png) ![](https://90daysdevops.295devops.com/assets/images/1-f3144a640ba8672d65d7d67dcd12fa42.png)

Vas a crear un entorno multi-servicio que incluya:

-   🐍 `vote`: una app Flask que permite votar (gato o perro)
-   🧠 `worker`: un servicio Node.js que procesa los votos
-   📊 `result`: una app Node.js que muestra los resultados en tiempo real
-   🗃️ `redis`: almacén temporal de votos
-   🐘 `postgres`: base de datos persistente

___

## 🌐 Puertos de los Servicios[](https://90daysdevops.295devops.com/semana-02/dia8#-puertos-de-los-servicios "Enlace directo al 🌐 Puertos de los Servicios")

A continuación, te detallamos los puertos utilizados por cada componente de la aplicación:

-   **vote**: expone el puerto **80** (HTTP) para la interfaz de votación.
-   **worker**: utiliza el puerto **3000** internamente (no suele exponerse fuera del contenedor).
-   **result**: expone el puerto **3000** para mostrar los resultados en tiempo real.
-   **redis**: utiliza el puerto **6379** para la comunicación entre servicios.
-   **postgres**: utiliza el puerto estándar **5432** para la base de datos.

> Asegurate de que estos puertos no estén en uso por otros servicios en tu máquina antes de levantar los contenedores.

___

## 🗂️ Archivos de referencia[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-archivos-de-referencia "Enlace directo al 🗂️ Archivos de referencia")

A continuación te dejamos ejemplos de archivos que podés usar como guía:

### `.env.example`[](https://90daysdevops.295devops.com/semana-02/dia8#envexample "Enlace directo al envexample")

```
REDIS_HOST=redis
REDIS_PORT=6379
DATABASE_HOST=database
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
DATABASE_NAME=votes
```

### `docker-compose.yml` (referencia)[](https://90daysdevops.295devops.com/semana-02/dia8#docker-composeyml-referencia "Enlace directo al docker-composeyml-referencia")

```
services:
    vote:
        build: ./vote
        ports:
            - "80:80"
        environment:
            - REDIS_HOST=${REDIS_HOST}
            - DATABASE_HOST=${DATABASE_HOST}
            - DATABASE_USER=${DATABASE_USER}
            - DATABASE_PASSWORD=${DATABASE_PASSWORD}
            - DATABASE_NAME=${DATABASE_NAME}
        depends_on:
            - redis

    result:
        build: ./result
        ports:
            - "3000:3000"
        environment:
            - APP_PORT=3000
            - DATABASE_HOST=${DATABASE_HOST}
            - DATABASE_USER=${DATABASE_USER}
            - DATABASE_PASSWORD=${DATABASE_PASSWORD}
            - DATABASE_NAME=${DATABASE_NAME}
        depends_on:
            - redis
            - database

    worker:
        build: ./worker    
        environment:
            - REDIS_HOST=${REDIS_HOST}
            - DATABASE_HOST=${DATABASE_HOST}
            - DATABASE_USER=${DATABASE_USER}
            - DATABASE_PASSWORD=${DATABASE_PASSWORD}
            - DATABASE_NAME=${DATABASE_NAME}
        depends_on:
            - redis
            - database

    redis:
        image: "redis:alpine"
        ports:
            - "6379:6379"

    database:
        image: "postgres:15-alpine"
        environment:
            POSTGRES_USER: ${DATABASE_USER}
            POSTGRES_PASSWORD: ${DATABASE_PASSWORD}
            POSTGRES_DB: ${DATABASE_NAME}
        ports:
            - "5432:5432"
        volumes:
            - pgdata:/var/lib/postgresql/data

volumes:
    pgdata:
```

> ⚠️ **Nota:** Este archivo es solo una referencia. Adaptalo según la estructura y necesidades de tu proyecto.

___

## 🛠️ Tareas del desafío[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-tareas-del-desaf%C3%ADo "Enlace directo al 🛠️ Tareas del desafío")

1.  **Crear los `Dockerfile` personalizados** para cada componente si aún no lo hiciste.
2.  **Escribir el archivo `docker-compose.yml`** que levante todos los servicios conectados.
3.  Asegurate de que:
    -   Todos los servicios se comuniquen entre sí correctamente.
    -   Los contenedores levanten sin errores.
    -   Los puertos estén bien expuestos (`5000`, `5001`, etc.).
4.  **(Opcional)** Agregá un volumen para persistir los datos de PostgreSQL.

___

## 🧩 Recomendaciones[](https://90daysdevops.295devops.com/semana-02/dia8#-recomendaciones "Enlace directo al 🧩 Recomendaciones")

-   Usá **build context** en Docker Compose para construir las imágenes desde cero.
-   Usá una **red personalizada** para facilitar la comunicación entre servicios.
-   Levantá todo con:

```
docker compose up --build
```

Y probá que podés acceder a:

-   `http://localhost` → para votar
-   `http://localhost:3000` → para ver los resultados

___

Si ya lograste levantar todo, podés ir un paso más allá:

-   Agregá variables de entorno con `.env`
-   Configurá `depends_on` correctamente
-   Probá detener un contenedor (como `worker`) y ver cómo afecta a la app
-   Agregá `healthcheck` a los servicios principales


___

## 🔗 Recursos útiles[](https://90daysdevops.295devops.com/semana-02/dia8#-recursos-%C3%BAtiles "Enlace directo al 🔗 Recursos útiles")

-   [Repositorio del Proyecto](https://github.com/roxsross/roxs-devops-project90)
-   [Markdown para Documentación](https://www.markdownguide.org/)
-   [DevOps Roadmap](https://roadmap.sh/devops)

