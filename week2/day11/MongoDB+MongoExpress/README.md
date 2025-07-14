## 🧪 Reto Adicional: MongoDB + Mongo Express

🎯 **Objetivo**: Crear un entorno con dos contenedores — MongoDB y Mongo Express — y conectarlos con Docker.

### Instrucciones:

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
```
administrator@ASC:~$ docker logs mongo-express
Waiting for mongo:27017...
No custom config.js found, loading config.default.js
Welcome to mongo-express 1.0.2
------------------------

Mongo Express server listening at http://0.0.0.0:8081
Server is open to allow connections from anyone (0.0.0.0)
basicAuth credentials are "admin:pass", it is recommended you change this in your config.js!
```
Credenciales de acceso web:
```
-e ME_CONFIG_BASICAUTH_USERNAME=admin \
-e ME_CONFIG_BASICAUTH_PASSWORD=secret \
```
4.  Crear la base de datos `Library` y la colección `Books`.
    
5.  Importar datos (`books.json`):
    