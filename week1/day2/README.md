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


### 11\. `ps` – Listar procesos

```
ps aux | grep nginx  # Buscar procesos de Nginx 
```

### 12\. `journalctl` – Ver logs de systemd

```
journalctl -u nginx  # Logs de Nginx  
journalctl -xe       # Últimos logs críticos 
```

### 13\. `ping` – Probar conectividad

```
ping -c 5 google.com  # Hacer 5 pings a Google 
```

### 14\. `telnet` – Probar puertos (¡pero usa `nc` mejor!)

```
telnet servidor.com 80  # Ver si el puerto 80 responde  
```

### 15\. `sed` – Editar texto en stream

```
sed -i 's/old/new/g' archivo.conf  # Reemplazar "old" por "new" 
```

### 16\. `awk` – Procesamiento de texto avanzado

```
awk '{print $1, $3}' access.log  # Extraer columnas 1 y 3 
```

### 17\. `grep` – Buscar patrones en archivos

```
grep -r "ERROR" /var/log/  # Buscar "ERROR" en logs  
```
___

## 📂 **Comandos por Categoría**

### **Sistema de Archivos**

```
df -hT       # Espacio en discos  
du -sh *     # Tamaño de archivos/carpetas  
tree -a      # Estructura de directorios  
```

### **Procesos**

```
lsof -i :80       # Ver qué usa el puerto 80  
kill -9 PID       # Matar proceso (¡cuidado!) 
```

### **Paquetes (Ubuntu/Debian)**

```
apt update &amp;&amp; apt upgrade  # Actualizar todo  
apt install docker.io              # Instalar Docker  
```

### **Trucos de Terminal**

```
comando1 &amp;&amp; comando2   # Ejecuta comando2 SOLO si comando1 funciona  
comando1 || comando2           # Ejecuta comando2 SOLO si comando1 falla  
```

## 🐧 Parte 2: El Sistema de Archivos de Linux

___

### 🌳 **¿Qué es el Filesystem Hierarchy Standard (FHS)?**

Es el "mapa" que sigue Linux para organizar archivos. Todos los distros lo usan.

![](https://90daysdevops.295devops.com/assets/images/1-6ca3021378f4a30d91183cf2cc73c3de.png)

> 📌 **Key Point**: _En Linux, todo parte del directorio raíz `/` (no hay "C:" como en Windows)._

___

### 🗂️ **Estructura Básica: Directorios Clave**

| Directorio | ¿Qué contiene? | Ejemplo Importante |
| --- | --- | --- |
| **`/`** | Raíz del sistema | ¡El punto de partida de todo! |
| **`/bin`** | Comandos básicos | `ls`, `cp`, `bash` |
| **`/sbin`** | Comandos de admin (root) | `iptables`, `fdisk` |
| **`/etc`** | Archivos de configuración | `/etc/passwd`, `/etc/nginx/` |
| **`/dev`** | Dispositivos (discos, USB) | `/dev/sda1` (tu disco duro) |
| **`/home`** | Directorios de usuarios | `/home/tu_usuario` |
| **`/var`** | Datos variables (logs, cachés) | `/var/log/nginx/` |
| **`/tmp`** | Archivos temporales | _(Se borra al reiniciar)_ |
| **`/boot`** | Archivos de arranque | `vmlinuz` (el kernel) |
| **`/opt`** | Software de terceros | `/opt/google/chrome/` |
| **`/proc`** | Info de procesos (virtual) | `/proc/cpuinfo` |
| **`/usr`** | Aplicaciones y librerías | `/usr/bin/python3` |

___

### 🔍 **Profundizando en Directorios Clave**

### 1\. **`/etc` – El "panel de control" de Linux**

📌 _Aquí viven TODAS las configuraciones:_

-   `/etc/passwd`: Usuarios del sistema.
-   `/etc/fstab`: Discos montados al iniciar.
-   `/etc/ssh/sshd_config`: Configuración de SSH.

### 2\. **`/var` – Donde Linux guarda lo que cambia**

-   `/var/log`: **Logs** (¡tu mejor amigo para debuggear!).
-   `/var/lib`: Bases de datos (Ej: `/var/lib/mysql/`).
-   `/var/www`: Sitios web (en algunas distros).

### 3\. **`/proc` y `/sys` – El "cerebro" de Linux**

-   **Virtuales**: No ocupan espacio en disco.
-   `/proc/cpuinfo`: Info del CPU.
-   `/proc/meminfo`: Uso de RAM.
-   `/sys/class/net/`: Config de red.

### 4\. **`/home` vs `/root`**

-   `/home/tu_usuario`: **Tus archivos** (documentos, descargas).
-   `/root`: **El "home" del admin** (no confundir con `/`).

___

## 💽 **Tipos de Filesystems en Linux**

| Tipo | ¿Para qué sirve? |
| --- | --- |
| **ext4** | El estándar (equilibrado). |
| **XFS** | Alto rendimiento (servidores). |
| **Btrfs** | Snapshots y RAID moderno. |
| **Swap** | "Memoria virtual" en disco. |

📌 **Comando útil**: Ver discos y espacio

```
df -hT  # Espacio libre en human-readable 
```

___

## 🛠️ **Herramientas para DevOps**

### 1\. **Ver uso de disco**

```
du -sh /var/log  # ¿Cuánto ocupan los logs?
du -sh * | sort -h  # Ordenar por tamaño  
```

### 2\. **Buscar archivos grandes**

```
find / -type f -size +100M  # Archivos &gt;100MB  
```

### 3\. **Monitorear logs en tiempo real**

```
tail -f /var/log/syslog  
```

## 🚀 **Conclusión**

-   **`/etc`**: Configuraciones.
-   **`/var/log`**: Logs (¡aprende a leerlos!).
-   **`/proc` y `/sys`**: Diagnóstico del sistema.
-   **`df -h` y `du -sh`**: Tus aliados para espacio en disco.


___

## 🐧 Parte 3: Gestión de Usuarios y Permisos en Linux

___

### ¿Por qué debería importarte los usuarios y permisos?

Imagina tu sistema Linux como un gran castillo. Los usuarios son tus nobles invitados, cada uno con sus roles y responsabilidades. Los permisos son las llaves que dan acceso a diferentes áreas del castillo, protegiendo el tesoro (tus datos valiosos) de invasores (software malicioso o miradas indiscretas).

Sin una gestión adecuada, tu castillo podría caer en el caos.

![](https://i.imgur.com/yxNrpKJ.png)

___

### El reparto: Usuarios, Grupos y Roles

### **Usuarios: Los habitantes de tu sistema**

En Linux, cada persona (o script) que interactúa con el sistema es un usuario. Hay tres tipos principales:

-   **Root (superusuario)**: Posee acceso ilimitado. Úsalo con precaución.
-   **Usuarios normales**: Poseen roles específicos y acceso limitado.
-   **Usuarios del sistema**: Aquellos que gestionan servicios y demonios. Normalmente no necesitan permisos de inicio de sesión.

### **Grupos: Formando tu comunidad**

Los grupos agrupan usuarios según roles o proyectos. Por ejemplo, un grupo _admin_ podría incluir a todos los usuarios que pueden realizar tareas administrativas.

### **Roles: Las responsabilidades asignadas**

Asignar roles es como repartir tareas. Puedes tener roles como _desarrollador_, _tester_ o _invitado_, cada uno con permisos específicos.

___

### Niveles de permisos: ¿Quién puede hacer qué?

Los permisos en Linux se dividen en tres tipos:

-   **Lectura (r)**: Puede ver el contenido.
-   **Escritura (w)**: Puede modificar o borrar el contenido.
-   **Ejecución (x)**: Puede ejecutar el archivo como programa.

Estos permisos se asignan a tres categorías:

1.  **Dueño (Owner)**: El usuario propietario del archivo.
2.  **Grupo (Group)**: Miembros del grupo asignado al archivo.
3.  **Otros (Others)**: Todos los demás.

___

### El poderoso comando `chmod`

Para controlar los permisos, usamos `chmod` (_change mode_). ¡Es como tu varita mágica para configurar accesos!

**Sintaxis:**

```
chmod [opciones] modo archivo
```

**Ejemplo:**

**Desglose de `755`:**

-   **7 (Dueño)**: Lectura + Escritura + Ejecución (`rwx`)
-   **5 (Grupo)**: Lectura + Ejecución (`r-x`)
-   **5 (Otros)**: Lectura + Ejecución (`r-x`)

**Regla mnemotécnica:**

-   `7 = 4 (r) + 2 (w) + 1 (x) = rwx`
-   `5 = 4 (r) + 1 (x) = r-x`

___

### Cambiando la propiedad con `chown`

Si necesitas transferir la propiedad de un archivo o directorio, usa `chown` (_change owner_).

**Sintaxis:**

```
chown [opciones] nuevo_dueño:nuevo_grupo archivo
```

**Ejemplo:**

```
chown alice:desarrolladores codigo_proyecto.py
```

Este comando asigna la propiedad de `codigo_proyecto.py` al usuario _alice_ y al grupo _desarrolladores_.

___

## Creando y gestionando usuarios: ¡Hagamos nuevos personajes!

### **Añadir un nuevo usuario**

### **Eliminar un usuario**

**Pro-tip:** Si _juan\_perez_ dejó archivos regados por el castillo, bórralos también:

```
sudo deluser --remove-home juan_perez 
# O también:
userdel -r juan_perez
```

### **Modificar un usuario**

Para añadir _juan\_perez_ al grupo `sudo` (dándole poderes administrativos):

```
sudo usermod -aG sudo juan_perez
```

**Otros ejemplos útiles:**

```
# Cambiar directorio home
usermod -d /nuevo/home -m usuario
# Cambiar shell de inicio
usermod -s /bin/zsh usuario
# Renombrar usuario
usermod -l nuevo_nombre antiguo_nombre
# Bloquear/desbloquear cuenta
usermod -L usuario  # Bloquea
usermod -U usuario  # Desbloquea
```

___

## Gestión de grupos: Reuniendo al equipo adecuado

### **Crear un nuevo grupo**

```
sudo groupadd desarrolladores
```

### **Añadir usuarios a un grupo**

```
sudo usermod -aG desarrolladores juan_perez
```

### **Ver miembros de un grupo**

```
getent group desarrolladores
```

___

## `sudo`: El poder de gobernar con responsabilidad

El comando `sudo` permite ejecutar comandos con privilegios de superusuario. ¡Es como darle a alguien la llave de la bóveda real!

**Ejemplo:**

**Configurar `sudoers` (editar con `visudo`):**

**Ejemplo de entrada:**

(Esto le da a _alice_ todos los permisos de `sudo`).

___



## Gestión de grupos:

### **Crear un nuevo grupo**
```
sudo groupadd desarrolladores
```

### **Listar grupos**
```
getent group
cat /etc/group
```

### **Añadir usuarios a un grupo**
```
sudo usermod -aG desarrolladores juan_perez
```

### **Ver miembros de un grupo**

```
getent group desarrolladores
```

___

## `sudo`

El comando `sudo` permite ejecutar comandos con privilegios de superusuario. 

**Ejemplo:**

```
sudo apt update
```
**Configurar `sudoers` (editar con `visudo`):**
```
sudo visudo
```

**Ejemplo de entrada:**
```
alice ALL=(ALL:ALL) ALL
```

(Esto le da a _alice_ todos los permisos de `sudo`).

___

## Errores comunes con permisos: 

### **El permiso `777`**

Dar permiso `777` a un archivo es como dejar las puertas del castillo abiertas durante un ataque de dragones. ¡Evítalo!

```
chmod 755 script_importante.sh  # Mejor opción
```

### **Confusión de propiedad**

Revisa siempre los permisos con:

**Salida ejemplo:**

```
-rw-r--r-- 1 alice desarrolladores 4096 oct 4 10:00 archivo.txt
```

(Aquí, _alice_ es el dueño y _desarrolladores_ el grupo).

___

## Tips para dominar usuarios y permisos

### **Usa alias para ser más eficiente**

Añade esto a tu `.bashrc` o `.zshrc`:

```
alias ll='ls -la'
alias gs='git status'
```

### **Aprovecha el poder de los grupos**

Asigna permisos a grupos en lugar de a usuarios individuales. ¡Es más fácil de gestionar!

### **Audita permisos regularmente**

Busca archivos con permisos peligrosos:

```
find / -type f -perm 0777
```

### **Principio de mínimo privilegio**

Solo da los permisos necesarios. ¡Menos es más!

___

## 🐧 Parte 4: 📦 Gestión de Paquetes en Linux

___

En Linux, el software se distribuye principalmente a través de **paquetes**, que contienen el programa, sus dependencias y metadatos (versión, mantenedor, etc.). Cada distribución usa su propio sistema de paquetes y gestores.

___

## 🔍 Formatos de Paquetes

| Formato | Distribuciones | Ejemplo de Gestor |
| --- | --- | --- |
| `.deb` | Debian, Ubuntu, Mint | `apt`, `dpkg` |
| `.rpm` | RHEL, Fedora, CentOS | `dnf`, `yum` |
| `.pkg.tar.zst` | Arch Linux, Manjaro | `pacman` |
| `.txz` | Slackware | `slackpkg` |

> 💡 **Nota**: Los paquetes universales como `.tar.gz` requieren compilación manual.

___

## 🛠️ Gestores de Paquetes por Distribución

### 1\. **Debian/Ubuntu (APT)**

```
# Actualizar lista de paquetes  
sudo apt update  

# Instalar un programa  
sudo apt install nginx  

# Buscar paquetes  
apt search python3  

# Eliminar un paquete  
sudo apt remove firefox  

# Limpiar paquetes no usados  
sudo apt autoremove  
```

\--

## 🔄 Comandos Esenciales

| Acción | Debian/Ubuntu | RHEL/Fedora | Arch Linux |
| --- | --- | --- | --- |
| **Actualizar repos** | `apt update` | `dnf check-update` | `pacman -Sy` |
| **Instalar** | `apt install` | `dnf install` | `pacman -S` |
| **Eliminar** | `apt remove` | `dnf remove` | `pacman -R` |
| **Buscar** | `apt search` | `dnf search` | `pacman -Ss` |
| **Ver detalles** | `apt show` | `dnf info` | `pacman -Qi` |

___

## 🏗️ Instalación desde Código Fuente
Si no hay paquete disponible:

```
# 1. Descargar y extraer 
wget https://ejemplo.com/app.tar.gz 
tar -xzvf app.tar.gz  
# 2. Instalar dependencias  
sudo apt build-dep .  
# 3. Compilar e instalar 
./configure  
make  
sudo make install 
```

___

## 💡 Buenas Prácticas

1.  **Usa repositorios oficiales** para mayor seguridad.
2.  **Evita `sudo` innecesario** (solo para instalaciones globales).
3.  **Mantén tu sistema actualizado**:
    
    ```
    sudo apt update &amp;&amp; sudo apt upgrade -y 
    ```
    
4.  **Revisa dependencias** antes de eliminar paquetes.

___

## 🚀 Caso Práctico: Instalar y Configurar Nginx

```
# Instalar  
sudo apt install nginx  
# Iniciar servicio  
sudo systemctl start nginx  
# Verificar  
curl localhost 
```

> ✅ **Resultado esperado**: Verás la página de bienvenida de Nginx.

___

## 🌍 Desplegando un "Hola Mundo" en Apache
Aprenderemos a configurar un servidor web Apache en Ubuntu/Debian y publicar una página HTML básica.

___

### 🛠️ Requisitos Previos

-   Máquina con Ubuntu/Debian (física o virtual)
-   Acceso a terminal con permisos de `sudo`

___

### 🔄 Paso 1: Actualizar el Sistema
```
sudo apt update &amp;&amp; sudo apt upgrade -y
```

**¿Por qué?**  
Asegura que todos los paquetes estén actualizados antes de instalar nuevos servicios.

___

### 🚀 Paso 2: Instalar Apache

```
sudo apt install apache2 -y
```

**Verificación:**

```
sudo systemctl status apache2
```

✅ Debes ver `active (running)` en verde.

___

### 📂 Paso 3: Crear la Página Web

1.  Navega al directorio raíz de Apache:

2.  Crea un archivo `index.html`:

3.  Inserta este código HTML:

```
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>¡DevOps en Acción!</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        h1 { color: #2c3e50; }
        .logo { width: 150px; }
    </style>
</head>
<body>
    <img src="https://git-scm.com/images/logos/downloads/Git-Logo-1788C.png" alt="Git Logo" class="logo">
    <h1>¡Hola Mundo DevOps!</h1>
    <p>Servidor Apache funcionando correctamente</p>
    <p>🛠️ Próximos pasos: Configurar HTTPS y un reverse proxy</p>
</body>
</html>
```

___

### 🔒 Paso 4: Configurar Permisos

```
sudo chown www-data:www-data /var/www/html/index.html
sudo chmod 644 /var/www/html/index.html
```

**Explicación:**

-   `www-data`: Usuario por defecto de Apache
-   `644`: Permisos de lectura para todos y escritura solo para el dueño

___

### 🌐 Paso 5: Acceder al Sitio

1.  Localmente:  
    Abre tu navegador en `http://localhost`
    
2.  Remotamente:  
    Usa la IP pública de tu servidor:
    

```
curl ifconfig.me  # Para obtener tu IP pública
```

Luego visita `http://<TU_IP>`

![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTR2KelFvX--Mz8eMm3dfgFQ1zUBLrGG9R_ZQ&s)

___

### 🚨 Solución de Problemas Comunes

### ❌ Error 403 Forbidden

```
sudo chmod 755 /var/www/html/
```

### ❌ Apache no inicia

Revisa logs con:

```
sudo journalctl -u apache2 --no-pager -n 20
```

___

### 📌 Buenas Prácticas

1.  **Eliminar la página por defecto**:

```
sudo rm /var/www/html/index.html  # Si existe una versión por defecto
```

2.  **Habilitar firewall**:

3.  **Próximos pasos**:
    -   Configurar dominio con DNS
    -   Añadir certificado SSL (Let's Encrypt)

___

## 🎓 Reto Adicional

Modifica la página para mostrar:

-   La hora del servidor (usa JavaScript)
-   El resultado del comando `uptime` (requiere CGI)

```
<script>
document.write("Hora del servidor: " + new Date().toLocaleString());
</script>
```

___

## 📚 Tarea Opcional del Día 2

> _Hoy activamos modo terminal: vas a explorar, crear, modificar y proteger archivos como toda persona DevOps debe saber hacer._ 🐧💻

___

### 🛠️ 1. Exploración básica

-   Abrí la terminal y ejecutá estos comandos. Luego anotá qué hace cada uno:
    
    ```
    whoami
    pwd
    ls -lah
    df -hT
    uptime
    ```
    
-   Navegá por los directorios clave del sistema:
    
    ```
    cd /
    ls
    cd /etc && ls
    cd /home && ls
    ```
    

___

### 📂 2. Crea y manipulá archivos

-   Creá una carpeta llamada `dia2-devops`
    
    ```
    mkdir ~/dia2-devops && cd ~/dia2-devops
    ```
    
-   Creá un archivo de prueba y escribile contenido:
    
    ```
    echo "Hola Roxs DevOps!" > saludos.txt
    ```
    
-   Copialo, renombralo y eliminá uno:
    
    ```
    cp saludos.txt copia.txt
    mv copia.txt hola.txt
    rm saludos.txt
    ```
    

___

### 👥 3. Usuarios y permisos

-   Creá un nuevo usuario en el sistema (si estás en Linux real o WSL):
    ```
    sudo adduser invitado
    ```
    
-   Creá un grupo y asigná ese usuario:
    
    ```
    sudo groupadd roxsdevs
    sudo usermod -aG roxsdevs invitado
    ```
    
-   Cambiá los permisos de un archivo para que:
    
    -   El dueño pueda leer/escribir/ejecutar
    -   El grupo solo leer
    -   Otros, nada
    
    ```
    chmod 740 hola.txt
    ls -l hola.txt
    ```
    

___

### 🔐 4. Buscá archivos con permisos peligrosos

-   Esto es oro puro en producción:
    
    ```
    find / -type f -perm 0777 2>/dev/null
    ```
    

___

### 🧠 5. Reto de comprensión

-   ¿Qué hace este comando?:
    
    ```
    chmod u=rwx,g=rx,o= hola.txt
    ```
    
    Explicalo con tus palabras.
    
