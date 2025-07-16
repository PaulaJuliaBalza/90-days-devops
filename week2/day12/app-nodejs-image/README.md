### 1 - Crear el archivo index.js

### 2 - Crear el archivo package.json

### 3 - Instalar las dependencias (crea archivo package-lock.json)
```
npm install
```

### 4 - Crear Dockerfile
```
FROM node:18-alpine
WORKDIR /app
COPY package.json ./
COPY index.js ./
RUN npm install
EXPOSE 3000
CMD ["npm", "start"]
```
### 5 - Construir la imagen
```
docker build -t hello-node-app .
```
### 6 - Ejecutar el contenedor
```
docker build -t hello-node-app .

curl http://localhost:3000
¡Hola desde Docker y Node.js!
```
📍 Navegá a: http://localhost:3000