### 1 - Crear el archivo server.js

### 2 - Crear el archivo package.json

### 3 - Instalar las dependencias (crea archivo package-lock.json)
```
npm install
```

### 4 - Crear Dockerfile
```
FROM node:18-alpine
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
```
### 5 - Ejecutar docker-compose
```
# Iniciar servicios
docker compose up -d

# Visualizar contenedores
docker-compose ps

# Probar la API
curl http://localhost:3000
# Deberías ver: "¡API conectada a MongoDB con Docker!"

# Verificar la DB
docker-compose exec db mongosh --eval "show dbs" 

# Detener y reiniciar los contenedores
docker-compose down && docker-compose up -d

# Verificar que los datos de MongoDB persisten
docker compose exec db mongosh --eval "db.test.insertOne({name: 'Ejemplo'})" 

# Reiniciar y comprobar que siguen existiendo
```

### Issues y soluciones
Backend no levanta.
```
# El backend aparece como exited
docker ps -a
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS                      PORTS                                                                                                                                  NAMES
66db532e7224   nodejsmongodb-backend   "docker-entrypoint.s…"   51 seconds ago   Exited (1) 44 seconds ago                                                                                                                                          nodejsmongodb-backend-1

docker logs 66db532e7224
node:internal/modules/cjs/loader:1143
  throw err;
  ^

Error: Cannot find module 'express'
Require stack:
- /app/server.js
    at Module._resolveFilename (node:internal/modules/cjs/loader:1140:15)
    at Module._load (node:internal/modules/cjs/loader:981:27)
    at Module.require (node:internal/modules/cjs/loader:1231:19)
    at require (node:internal/modules/helpers:177:18)
    at Object.<anonymous> (/app/server.js:1:17)
    at Module._compile (node:internal/modules/cjs/loader:1364:14)
    at Module._extensions..js (node:internal/modules/cjs/loader:1422:10)
    at Module.load (node:internal/modules/cjs/loader:1203:32)
    at Module._load (node:internal/modules/cjs/loader:1019:12)
    at Function.executeUserEntryPoint [as runMain] (node:internal/modules/run_main:128:12) {
  code: 'MODULE_NOT_FOUND',
  requireStack: [ '/app/server.js' ]
}

Node.js v18.20.8

Para que vuelva a buildear:
docker compose up --build -d

administrator@ASC:~/Escritorio/90-days-devops/week2/day13/nodejs+mongodb/backend$ curl http://localhost:3000
¡API conectada a MongoDB con Docker!administrator@ASC

```

### Mejoras
- Usar .env para todo lo configurable
- Healthchecks en servicios críticos
- Perfiles para separar entornos
- Nombres explícitos para redes y volúmenes
- Nuevo comando docker compose (sin guión)

### Front
```
cd nodejs+mongodb/fronend
npm create vite@latest . -- --template react
npm install

# Levantar docker compose y forzar build
docker compose up --build -d

administrator@ASC:~/Escritorio/90-days-devops/week2/day13/nodejs+mongodb$ docker ps
CONTAINER ID   IMAGE                   COMMAND                  CREATED          STATUS                   PORTS                                       NAMES
c8fcdfd096c3   node:18-alpine          "docker-entrypoint.s…"   10 seconds ago   Up 3 seconds             0.0.0.0:5173->5173/tcp, :::5173->5173/tcp   nodejsmongodb-frontend-1
9d7a367df1a3   nodejsmongodb-backend   "docker-entrypoint.s…"   10 seconds ago   Up 4 seconds             0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   nodejsmongodb-backend-1
7f4cb5d81854   mongo:6                 "docker-entrypoint.s…"   10 seconds ago   Up 9 seconds (healthy)   27017/tcp                                   nodejsmongodb-db-1

Error de frontend:
administrator@ASC:~/Escritorio/90-days-devops/week2/day13/nodejs+mongodb$ docker logs c8fcdfd096c3

> frontend@0.0.0 dev
> vite --host

/app/node_modules/rollup/dist/native.js:64
		throw new Error(
		      ^

Error: Cannot find module @rollup/rollup-linux-x64-musl. npm has a bug related to optional dependencies (https://github.com/npm/cli/issues/4828). Please try `npm i` again after removing both package-lock.json and node_modules directory.
    at requireWithFriendlyError (/app/node_modules/rollup/dist/native.js:64:9)
    at Object.<anonymous> (/app/node_modules/rollup/dist/native.js:73:76)
    ... 3 lines matching cause stack trace ...
    at Module._load (node:internal/modules/cjs/loader:1019:12)
    at ModuleWrap.<anonymous> (node:internal/modules/esm/translators:203:29)
    at ModuleJob.run (node:internal/modules/esm/module_job:195:25)
    at async ModuleLoader.import (node:internal/modules/esm/loader:337:24) {
  [cause]: Error: Cannot find module '@rollup/rollup-linux-x64-musl'
  Require stack:
  - /app/node_modules/rollup/dist/native.js
      at Module._resolveFilename (node:internal/modules/cjs/loader:1140:15)
      at Module._load (node:internal/modules/cjs/loader:981:27)
      at Module.require (node:internal/modules/cjs/loader:1231:19)
      at require (node:internal/modules/helpers:177:18)
      at requireWithFriendlyError (/app/node_modules/rollup/dist/native.js:46:10)
      at Object.<anonymous> (/app/node_modules/rollup/dist/native.js:73:76)
      at Module._compile (node:internal/modules/cjs/loader:1364:14)
      at Module._extensions..js (node:internal/modules/cjs/loader:1422:10)
      at Module.load (node:internal/modules/cjs/loader:1203:32)
      at Module._load (node:internal/modules/cjs/loader:1019:12) {
    code: 'MODULE_NOT_FOUND',
    requireStack: [ '/app/node_modules/rollup/dist/native.js' ]
  }
}
vite incompatible con alpine:
Error: Cannot find module @rollup/rollup-linux-x64-musl.

docker-compose down
rm -rf frontend/node_modules frontend/package-lock.json
docker-compose up --build -d

```

Actualizar paquetes:
```
# Desde frontend/
rm -rf node_modules package-lock.json
npm install
```

#### Frontend + Backend
```
administrator@ASC:~/Escritorio/90-days-devops/week2/day13/nodejs+mongodb$ docker ps
CONTAINER ID   IMAGE                    COMMAND                  CREATED         STATUS                   PORTS                                       NAMES
16f30f43561b   nodejsmongodb-frontend   "docker-entrypoint.s…"   8 minutes ago   Up 8 minutes             0.0.0.0:5173->5173/tcp, :::5173->5173/tcp   nodejsmongodb-frontend-1
65a36db74402   nodejsmongodb-backend    "docker-entrypoint.s…"   8 minutes ago   Up 8 minutes             0.0.0.0:3000->3000/tcp, :::3000->3000/tcp   nodejsmongodb-backend-1
2d0fe0bab51f   mongo:6                  "docker-entrypoint.s…"   8 minutes ago   Up 8 minutes (healthy)   27017/tcp                                   nodejsmongodb-db-1
```