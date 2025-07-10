#!/bin/bash

# Directorio base de la aplicación
APP_BASE_DIR="/vagrant"

# Variables de entorno
export REDIS_HOST=localhost
export DATABASE_HOST=localhost
export DATABASE_USER=postgres
export DATABASE_PASSWORD=postgres
export DATABASE_NAME=votes
export OPTION_A="Cats"
export OPTION_B="Dogs"

# Iniciar Redis y PostgreSQL (si no están corriendo)
sudo service redis-server status > /dev/null 2>&1 || sudo service redis-server start
sudo service postgresql status > /dev/null 2>&1 || sudo service postgresql start

# Crear directorio de pids si no existe
mkdir -p /tmp/roxs-voting-app

# Iniciar las aplicaciones
echo "Iniciando las aplicaciones..."

# Iniciar la aplicación de votación (Python)
cd "$APP_BASE_DIR/roxs-voting-app/vote"
nohup python3 app.py > vote.log 2>&1 &
echo $! > /tmp/roxs-voting-app/vote.pid
echo "Aplicación 'vote' iniciada con PID $(cat /tmp/roxs-voting-app/vote.pid)."

# Iniciar el worker (Node.js)
cd "$APP_BASE_DIR/roxs-voting-app/worker"
nohup node main.js > worker.log 2>&1 &
echo $! > /tmp/roxs-voting-app/worker.pid
echo "Aplicación 'worker' iniciada con PID $(cat /tmp/roxs-voting-app/worker.pid)."

# Iniciar la aplicación de resultados (Node.js)
cd "$APP_BASE_DIR/roxs-voting-app/result"
nohup node main.js > result.log 2>&1 &
echo $! > /tmp/roxs-voting-app/result.pid
echo "Aplicación 'result' iniciada con PID $(cat /tmp/roxs-voting-app/result.pid)."

cd "$APP_BASE_DIR"

echo "Todos los servicios están iniciados."
echo "Votá en: http://localhost:8080/"
echo "Resultados en: http://localhost:3000/"
echo "Para detener las aplicaciones, ejecuta: ./stop_apps.sh"