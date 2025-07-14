### 1 - Crear una red personalizada miapp-net
```
docker network create miapp-net

administrator@ASC:~$ docker network ls
NETWORK ID     NAME                        DRIVER    SCOPE
00e8f7992582   bridge                      bridge    local
5e2b4b3d408c   host                        host      local
0c3ad8dc59ec   k3d-k3s-default             bridge    local
5fa73ff9b879   miapp-net                   bridge    local
6a1be4797e86   minikube                    bridge    local
76111a687706   none                        null      local
494b87393a63   proxus_mqtt_bench_default   bridge    local

```
### 2 - Ejecutar dos contenedores api y db (montar volumen vol-db en /datos dentro del contenedor) en esa red
```
# Contenedor db
# Si no especifico un path se guarda por defecto en /var/lib/docker/volumes/
# docker volume ls
# Inspect
administrator@ASC:$ docker volume inspect vol-db
[
    {
        "CreatedAt": "2025-07-14T17:00:38-03:00",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/vol-db/_data",
        "Name": "vol-db",
        "Options": null,
        "Scope": "local"
    }
]

docker run -dit --name db --network miapp-net --mount source=vol-db,target=/datos alpine

# Contenedor api con Alpine para testeo

```
### 3 - Desde api hacer ping a db
```
docker exec -it api ping db

administrator@ASC:~$ docker exec -it api ping db
PING db (172.20.0.2): 56 data bytes
64 bytes from 172.20.0.2: seq=0 ttl=64 time=0.071 ms
64 bytes from 172.20.0.2: seq=1 ttl=64 time=0.093 ms
64 bytes from 172.20.0.2: seq=2 ttl=64 time=0.094 ms
^C
--- db ping statistics ---
3 packets transmitted, 3 packets received, 0% packet loss
round-trip min/avg/max = 0.071/0.086/0.094 ms

```
### 4 - Desde db, escribir un archivo en /datos/info.txt
```
docker exec -it db sh
echo "Hola desde el volumen" > /datos/info.txt

administrator@ASC:~$ docker exec -it db sh
/ # echo "Hola desde el volumen" > /datos/info.txt
/ # cat /datos/info.txt 
Hola desde el volumen

exit
```
### 5 - Eliminar el contenedor db, volver a crearlo y verificar si el archivo sigue
```
docker rm -f db

docker run -dit --name db --network miapp-net --mount source=vol-db,target=/datos alpine

docker exec -it db sh
cat /datos/info.txt

administrator@ASC:~$ docker exec -it db sh
/ # cat /datos/info.txt
Hola desde el volumen
```