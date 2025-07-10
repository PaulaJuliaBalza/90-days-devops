
# Día 7 - Desafío Final Semana 1 | 90DevOps Roxs

## Objetivo
Poner en marcha **Roxs Voting App**, una aplicación de votación distribuida que te permitirá aplicar conceptos de Linux, scripting, automatización con Ansible y máquinas virtuales con Vagrant.

### Pasos:
✅ Clonar el repositorio del proyecto educativo
✅ Usar Vagrant para levantar el entorno
✅ Automatizar configuraciones básicas
✅ Ejecutar los tres servicios (Vote, Worker, Result)
✅ Validar que los datos fluyan desde la votación hasta la visualización

### Repositorio base
```
git clone https://github.com/roxsross/roxs-devops-project90.git
cd roxs-devops-project90
```
Solo están disponibles los servicios. 

### Arquitectura
```
[ Vote (Flask) ] ---> Redis ---> [ Worker (Node.js) ] ---> PostgreSQL
                                       ↓
                               [ Result (Node.js) ]
```
```
[Usuario] 
   │
   ▼
[Vote (Flask)] --(voto)--> [Redis] --(voto)--> [Worker (Node.js)] --(voto)--> [PostgreSQL]
                                                                                   │
                                                                                   ▼
                                                                       [Result (Node.js + WebSockets)]
                                                                                   │
                                                                                   ▼
                                                                             [Usuario]
```
Cada componente vive en su propia carpeta y puede ser iniciado de forma independiente.

vote (roxs-voting-app/vote/app.py)
- Tecnología: Python (Flask)
- Función:  es la aplicación web donde los usuarios votan por su opción favorita (por defecto "Cats" o "Dogs").
- Flujo:
   - Renderiza un formulario web (index.html) para votar.
   - Cuando un usuario vota, el voto se almacena temporalmente en una cola de Redis (no directamente en la DB).
   - Usa cookies para identificar a cada votante.
   - Expone endpoints de métricas Prometheus (/metrics), estadísticas (/stats) y healthcheck (/healthz).
- Interacción: Publica los votos en Redis para ser procesados por el worker.

worker (roxs-voting-app/worker/main.js)
- Tecnología: Node.js.
- Función: es el servicio backend que procesa los votos.
- Flujo:
  - Se conecta a Redis y PostgreSQL
  - Lee los votos de la cola de Redis
  - Inserta o actualiza los votos en la DB PostgreSQL
  - Expone endpoints de métricas Prometheus (/metrics) y healthcheck (/healtz)
- Interación: consume los votos de Redis (producidos por vote) y los almacena en PostgreSQL, que luego serán leídos por el servicio de resultados.

result (roxs-voting-app/result/main.js)
- Tecnología: Node.js + AngularJS (frontend)
- Función: Muestra los resultados de la votación en tiempo real.
- Flujo:
  - Se conecta a la DB de PostgreSQL para leer los votos.
  - Usa WebSocket (socket.io) para enviar actualizaciones en tiempo real a los clientes.
  - Expone endpoints de métricas Prometheus (/metrics) y healthchecks (/healtz).
  - Sirve la interfaz web (index.html) que muestra los resultados y animaciones.
- Interacción: lee los votos desde PostgreSQL (escritos por el worker) y los muestra en tiempo real a los usuarios.

load-testing (roxs-voting-app/load-testing/k6.js)
- Tecnología: K8 (JavaScript)
- Función: permite realizar pruebas de carga automatizada sobre el sistema de votación.
- Flujo:
  - Simula múltiples usuarios voyando y verifica la robustez y performance de la aplicación.
  - Genera reportes de métricas y resultados de la prueba.

### Interrelación de los componentes
- Usuarios --> Vote: el usuario accede a la web de votación y envía su voto.
- Vote --> Redis: el servicio vote toma el voto y lo coloca en una cola de Redis.
- Worker <-- Redis: el worker lee los votos de Redis, los procesa y los guarda en la DB PostgreSQL.
- Result <-- PostgreSQL: el servicio result consulta la DB para obtener los resultados agregados y los muestra en el tiempo real a través de WebSockets.
- Usuario <-- Result: los usuarios ven los resultados actualizados en tiempo real en la web de resultados.
- Métricas y observabilidad: todos los servicios exponen métricas Prometheus para monitoreo y endpoints de healthcheck para verificar su estado.

### Resumen
- vote: recibe votos y los publica en Redis
- worker: procesa votos desde Redis y los almacena en PostgreSQL
- result: lee votos desde PostgreSQL y muestra resultados en tiempo real
- load-testing: prueba la robustez y oerformance de todo el flujo

### Rseumen de relaciones y puertos
## Resumen de relaciones y puertos

| Componente | Puerto | Endpoints principales                  | Se conecta a...                        |
|------------|--------|----------------------------------------|----------------------------------------|
| Vote       | 80     | `/`, `/metrics`, `/stats`, `/healthz`  | Redis:6379                             |
| Worker     | 3000   | `/`, `/metrics`, `/healthz`            | Redis:6379, PostgreSQL:5432            |
| Result     | 3000   | `/`, `/metrics`, `/healthz`            | PostgreSQL:5432, WebSockets            |
| Load Test  | -      | `/`, `/stats`                          | Vote (por HTTP)                        |

### Puertos de la aplicación
Cada servicio expone un puerto distinto en mi máquina local:
| Servicio    | Descripción                                       | Puerto               |
|-------------|---------------------------------------------------|----------------------|
| Vote        | Formulario de votación (Flask)                    | 80                   |
| Result      | Resultados en tiempo real (Node.js + WebSocket)   | 3000                 |
| Redis       | Almacenamiento temporal de votos                  | 6379                 |
| Worker      | Proceso en segundo plano (Node.js)                | — (sin puerto expuesto) |
| PostgreSQL  | Base de datos relacional para los resultados      | 5432                 |

🧠 Tip: Podés acceder al formulario de votación en tu navegador con http://localhost y los resultados en http://localhost:3000.

### Requisitos
Tener instalado:
- Git
- Vagrant
- VirtualBox
- Python 3.13+, Node.js 20+

### Actividades
1. Usar un Vagrantfile para levantar una máquina Ubuntu local
2. Automatizar la instalación de Redis, PostgreSQL, Python y Node.js con Ansible
3. Ejecutar manualmente cada componente de la app
4. Validar que puedas votar y ver el resultado en el navegador

Bonus: creá un script llamado iniciar_app.sh que levante todos los servicios

### Resultado esperado
- App funcional en entorno local
- Automatización básica de dependencias
- Experiencia práctica de orquestar servicios sin Docker (aún)

## Solution
Si los archivos están en el mismo directorio que el Vagrantfile se sincronizan con el usuario vagrant en la VM:
```
vagrant@ubuntu-jammy:/vagrant$ ls
README.md  Vagrantfile  provision.yml  roxs-voting-app  start_app.sh
```


Ejecutar script de inicialización:
```
cd vagrant/
vagrant@ubuntu-jammy:/vagrant$ ls
README.md  Vagrantfile  provision.yml  roxs-voting-app  start_app.sh
chmod +x start_app.sh
./start_app.sh 
```
Postgresql issue:
https://stackoverflow.com/questions/73059780/using-ansible-to-create-postgres-user-on-aws-vps-ubuntu-22-04 

vagrant@ubuntu-jammy:/vagrant$ psql -U postgres -d votes -h 127.0.0.1
Password for user postgres: 
psql (14.18 (Ubuntu 14.18-0ubuntu0.22.04.1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
Type "help" for help.

votes=# SELECT * FROM votes;
       id        | vote |        created_at         
-----------------+------+---------------------------
 7858976d9f9013d | a    | 2025-07-10 23:11:18.16814
(1 row)

votes=# 

