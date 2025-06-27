# Día 2: Introducción a Linux y a la terminal

## Parte 1: Comandos básicos 
### 1\. `alias` – Atajos para comandos

Crea **alias** para ahorrar tiempo:

```
alias ll='ls -lah --color=auto'  # Lista archivos con detalles  
alias ..='cd ..'                 # Sube un directorio  
alias gs='git status'            # Ver estado de Git  
```

📌 **Tip**: Se pueden guardar en `~/.bashrc` o `~/.zshrc` para que sean permanentes.

### 2\. `whoami` – ¿Quién soy?

```
whoami  # Muestra el usuario actual  
```

Útil en scripts para verificar permisos:

```
if [ "$(whoami)" != "root" ]; then  
    echo "¡Error! Necesitas ser root."  
    exit 1  
fi  
```

### 3\. `ssh` – Conexión remota segura

```
ssh usuario@servidor          # Conexión básica  
ssh -p 2222 usuario@servidor  # Puerto personalizado  
ssh -i ~/.ssh/mi_llave usuario@servidor  # Usar clave privada  
```

### 4\. `scp` – Copiar archivos de forma segura

```
scp archivo.txt usuario@servidor:/ruta/  # Copiar un archivo  
scp -r carpeta/ usuario@servidor:/ruta/  # Copiar una carpeta (recursivo)  
```

### 5\. `nc` (Netcat) – El "navaja suiza" de redes

```
nc -zv servidor.com 80-100    # Escanear puertos  
nc -l 1234 > archivo_recibido  # Recibir un archivo  
```

### 6\. `ss` – Estadísticas de sockets (reemplaza a `netstat`)

```
ss -tuln    # Ver puertos abiertos (TCP/UDP)  
ss -tunlp | grep nginx  # Ver si Nginx está escuchando  
```

### 7\. `systemctl` – Gestión de servicios (systemd)
```
systemctl restart nginx    # Reiniciar Nginx  
systemctl status nginx    # Ver estado  
systemctl enable nginx    # Activar en el arranque  
```

### 8\. `service` – Alternativa antigua (para sistemas init.d)

```
service apache2 restart   # Reiniciar Apache (en sistemas viejos)  
```

### 9\. `uptime` – Tiempo de actividad del sistema

```
uptime  # Muestra: "16:12 up 20 days, load: 0.20, 0.18, 0.08"  
```

### 10\. `top` / `htop` – Monitor en tiempo real

```
top     # Monitoreo básico (CPU, RAM, procesos)  
htop    # Versión mejorada (colorida y más intuitiva)  
```

📌 **Tip**: En `top`, presiona:

-   `1` → Ver todos los núcleos CPU.
-   `m` → Ordenar por uso de memoria.

