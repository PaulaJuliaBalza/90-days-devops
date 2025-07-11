
# Día 8: Conceptos básicos de contenedores Docker

## 🎯 ¿Por qué deberías aprender Docker?[](https://90daysdevops.295devops.com/semana-02/dia8#-por-qu%C3%A9-deber%C3%ADas-aprender-docker "Enlace directo al 🎯 ¿Por qué deberías aprender Docker?")

En el camino DevOps, trabajamos con múltiples entornos: desarrollo, testing, staging, producción. Lo que funciona en una máquina, puede no funcionar en otra. Docker resuelve eso.

> "Con Docker, empaquetás una aplicación _con TODO lo que necesita_ para que corra igual en cualquier lugar."

Ya no tendrás que decir:  
❌ “En mi máquina sí funciona...”  
✅ “¡Con Docker funciona en todas!”

___

## 🧠 ¿Qué es Docker?[](https://90daysdevops.295devops.com/semana-02/dia8#-qu%C3%A9-es-docker "Enlace directo al 🧠 ¿Qué es Docker?")

**Docker** es una plataforma open-source que permite desarrollar, enviar y ejecutar aplicaciones dentro de **contenedores**. Un contenedor es una unidad ligera y portable que incluye todo lo necesario para ejecutar una aplicación: código, runtime, librerías, variables de entorno y más.

Para profundizar en Docker y resolver dudas, consulta siempre la [documentación oficial de Docker](https://docs.docker.com/). Allí encontrarás guías, referencias de comandos, ejemplos y buenas prácticas para todos los niveles.

___

## 🏗️ Arquitectura de Docker[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-arquitectura-de-docker "Enlace directo al 🏗️ Arquitectura de Docker")

Docker tiene tres componentes clave:

![](https://docs.docker.com/get-started/images/docker-architecture.webp)

| Componente | Descripción |
| --- | --- |
| **Docker Engine** | Motor principal que permite crear y ejecutar contenedores |
| **Docker Daemon (`dockerd`)** | Servicio que corre en segundo plano, administra contenedores e imágenes |
| **CLI (`docker`)** | Herramienta de línea de comandos para interactuar con Docker |
| **Docker Hub** | Registro público donde se almacenan y comparten imágenes de contenedores |

### 🧱 ¿Cómo funciona internamente?[](https://90daysdevops.295devops.com/semana-02/dia8#-c%C3%B3mo-funciona-internamente "Enlace directo al 🧱 ¿Cómo funciona internamente?")

1.  **Imágenes**: Plantillas inmutables. Contienen el sistema de archivos, dependencias y comandos.
2.  **Contenedores**: Instancias en ejecución de una imagen.
3.  **Volúmenes**: Permiten persistir datos incluso si el contenedor se elimina.
4.  **Redes**: Docker crea redes virtuales para comunicar contenedores entre sí.

___

## 🆚 Docker vs Máquinas Virtuales[](https://90daysdevops.295devops.com/semana-02/dia8#-docker-vs-m%C3%A1quinas-virtuales "Enlace directo al 🆚 Docker vs Máquinas Virtuales")

| Característica | Contenedor (Docker) | Máquina Virtual |
| --- | --- | --- |
| Arranque | Rápido (segundos) | Lento (minutos) |
| Peso | Ligero (MBs) | Pesado (GBs) |
| Aislamiento | Parcial (comparten kernel) | Total (kernel propio) |
| Uso de recursos | Eficiente | Alto |
| Portabilidad | Alta | Limitada |
| Velocidad de despliegue | Muy rápida | Más lenta |

___

## 🛠️ Instalación de Docker[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-instalaci%C3%B3n-de-docker "Enlace directo al 🛠️ Instalación de Docker")

### Opción recomendada: Instalación desde repositorios oficiales[](https://90daysdevops.295devops.com/semana-02/dia8#opci%C3%B3n-recomendada-instalaci%C3%B3n-desde-repositorios-oficiales "Enlace directo al Opción recomendada: Instalación desde repositorios oficiales")

```
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
```

Agregar la clave GPG:

```
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
```

Agregar el repositorio:

```
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

Instalar Docker Engine:

```
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-pluginan>
```

Agregar tu usuario al grupo `docker` (opcional pero recomendado):

```
sudo usermod -aG docker $USER
su - $USER
```

Verificar:
```
docker --version
```
### Comunidad: Moby[](https://90daysdevops.295devops.com/semana-02/dia8#comunidad-moby "Enlace directo al Comunidad: Moby")

Además de Docker, existe la comunidad **Moby**, un proyecto open-source que sirve como base tecnológica para Docker y otras herramientas de contenedores. Moby permite a desarrolladores y empresas construir sus propias soluciones de contenedores personalizadas utilizando componentes modulares.

-   [Sitio oficial de Moby](https://mobyproject.org/)
-   [Repositorio en GitHub](https://github.com/moby/moby)

Si usamos debian o ubuntu podemos realizar la instalación de la versión de la comunidad:
```
apt install docker.io
```
### Instalación con Docker Desktop[](https://90daysdevops.295devops.com/semana-02/dia8#instalaci%C3%B3n-con-docker-desktop "Enlace directo al Instalación con Docker Desktop")

Si usas **Windows** o **macOS**, la forma más sencilla de instalar Docker es mediante **Docker Desktop**:

![](https://www.docker.com/app/uploads/2023/07/docker-desktop-421_f2-1110x653.png)

1.  Descarga Docker Desktop desde la [página oficial](https://www.docker.com/products/docker-desktop/).
2.  Ejecuta el instalador y sigue los pasos indicados.
3.  Una vez instalado, abre Docker Desktop y espera a que el servicio inicie.
4.  Abre una terminal (CMD, PowerShell o Terminal en macOS) y verifica la instalación con:
```
docker --version
```
Docker Desktop incluye una interfaz gráfica para gestionar contenedores, imágenes, volúmenes y redes, facilitando el trabajo tanto a principiantes como a usuarios avanzados.

___

## 👋 ¡Hola mundo desde un contenedor![](https://90daysdevops.295devops.com/semana-02/dia8#-hola-mundo-desde-un-contenedor "Enlace directo al 👋 ¡Hola mundo desde un contenedor!")

Vamos a ejecutar tu primer contenedor:
```
docker run hello-world
```
Esto hace lo siguiente:

-   Descarga una imagen mínima desde Docker Hub.
-   Crea un contenedor basado en esa imagen.
-   Muestra un mensaje de éxito.

Si ves el mensaje: **“Hello from Docker!”**, todo está funcionando.

___

## 🔍 Comandos básicos de Docker[](https://90daysdevops.295devops.com/semana-02/dia8#-comandos-b%C3%A1sicos-de-docker "Enlace directo al 🔍 Comandos básicos de Docker")

| Acción | Comando |
| --- | --- |
| Ver contenedores activos | `docker ps` |
| Ver todos los contenedores | `docker ps -a` |
| Descargar una imagen | `docker pull <nombre>` |
| Ejecutar una imagen | `docker run <nombre>` |
| Detener un contenedor | `docker stop <id>` |
| Eliminar un contenedor | `docker rm <id>` |
| Eliminar una imagen | `docker rmi <id>` |

___

## 🧩 Recursos recomendados[](https://90daysdevops.295devops.com/semana-02/dia8#-recursos-recomendados "Enlace directo al 🧩 Recursos recomendados")

-   📘 [Guía oficial de instalación de Docker](https://docs.docker.com/engine/install/)
-   🐳 [Play with Docker (laboratorio online)](https://labs.play-with-docker.com/)
-   📎 [Cheat Sheet de Docker](https://dockerlabs.collabnix.com/docker/cheatsheet/)

___

## 💪 Tarea del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-tarea-del-d%C3%ADa "Enlace directo al 💪 Tarea del Día")

1.  Instala Docker siguiendo la guía.
2.  Ejecutá `docker run hello-world`.
3.  Usá los comandos `ps`, `images`, `pull`, `run` con alguna imagen como `nginx` o `alpine`.

___

##  Tarea extra: Docker 
Te recomendamos realizar el [Docker Workshop oficial](https://docs.docker.com/get-started/workshop/), un taller guiado de 45 minutos con instrucciones paso a paso para comenzar con Docker. Aprenderás a:

-   Construir y ejecutar una imagen como contenedor.
-   Compartir imágenes usando Docker Hub.
-   Desplegar aplicaciones Docker con múltiples contenedores y una base de datos.
-   Ejecutar aplicaciones usando Docker Compose.

