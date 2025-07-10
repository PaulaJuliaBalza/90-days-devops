#!/bin/bash

# Directorio de PIDs
PID_DIR="/tmp/roxs-voting-app"

# Verificar si el directorio de PIDs existe
if [ ! -d "$PID_DIR" ]; then
  echo "El directorio de PIDs no existe. ¿Están las aplicaciones corriendo?"
  exit 1
fi

# Detener las aplicaciones
echo "Deteniendo las aplicaciones..."

for pid_file in $PID_DIR/*.pid; do
  if [ -f "$pid_file" ]; then
    pid=$(cat "$pid_file")
    app_name=$(basename "$pid_file" .pid)
    if ps -p $pid > /dev/null; then
      echo "Deteniendo $app_name (PID $pid)..."
      kill $pid
      rm "$pid_file"
    else
      echo "La aplicación $app_name (PID $pid) no está corriendo."
      rm "$pid_file"
    fi
  fi
done

# Eliminar el directorio de PIDs si está vacío
if [ -z "$(ls -A $PID_DIR)" ]; then
  rmdir "$PID_DIR"
fi

echo "Aplicaciones detenidas."
