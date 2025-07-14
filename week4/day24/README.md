# Día 24 - Provider Docker en Terraform | 90DevOps Roxs

-   [🐳 Provider Docker en Terraform](#-provider-docker-en-terraform)
-   [🔌 ¿Qué es el Provider Docker?](#-qué-es-el-provider-docker)
-   [🛠️ Configuración Inicial](#️-configuración-inicial)
    -   [Prerequisitos](#prerequisitos)
    -   [Configuración del Provider](#configuración-del-provider)
-   [🖼️ Gestión de Imágenes Docker](#️-gestión-de-imágenes-docker)
    -   [Pulling Imágenes](#pulling-imágenes)
    -   [Building Imágenes Personalizadas](#building-imágenes-personalizadas)
-   [📦 Gestión de Contenedores](#-gestión-de-contenedores)
    -   [Contenedor Básico](#contenedor-básico)
    -   [Contenedor Avanzado](#contenedor-avanzado)
-   [🌐 Gestión de Redes](#-gestión-de-redes)
    -   [Red Personalizada](#red-personalizada)
-   [💾 Gestión de Volúmenes](#-gestión-de-volúmenes)
    -   [Volúmenes Nombrados](#volúmenes-nombrados)
-   [🔧 Ejemplo Completo: Stack de Aplicación](#-ejemplo-completo-stack-de-aplicación)
    -   [`main.tf`](#maintf)
    -   [`variables.tf`](#variablestf)
    -   [`outputs.tf`](#outputstf)
-   [🔍 Comandos Útiles](#-comandos-útiles)
    -   [Gestión del Stack](#gestión-del-stack)
    -   [Debugging](#debugging)
-   [📊 Data Sources](#-data-sources)
-   [🚨 Mejores Prácticas](#-mejores-prácticas)
    -   [1\. **Gestión de Imágenes**](#1-gestión-de-imágenes)
    -   [2\. **Configuración de Contenedores**](#2-configuración-de-contenedores)
    -   [3\. **Redes y Seguridad**](#3-redes-y-seguridad)
    -   [4\. **Variables Sensibles**](#4-variables-sensibles)
-   [✅ ¿Qué Aprendiste Hoy?](#-qué-aprendiste-hoy)
-   [🔮 ¿Qué Sigue Mañana?](#-qué-sigue-mañana)


## 🐳 Provider Docker en Terraform[​](#-provider-docker-en-terraform "Enlace directo al 🐳 Provider Docker en Terraform")

Aprenderemos a gestionar **contenedores Docker** usando **Terraform**, combinando Infrastructure as Code con containerización.

---

## 🔌 ¿Qué es el Provider Docker?[​](#-qué-es-el-provider-docker "Enlace directo al 🔌 ¿Qué es el Provider Docker?")

El **Docker Provider** permite a Terraform gestionar recursos Docker:

-   🖼️ **Imágenes Docker** (pull, build, tag)
-   📦 **Contenedores** (crear, configurar, gestionar lifecycle)
-   🌐 **Redes** (crear redes personalizadas)
-   💾 **Volúmenes** (almacenamiento persistente)
-   🏷️ **Registries** (autenticación y gestión)

---

## 🛠️ Configuración Inicial[​](#️-configuración-inicial "Enlace directo al 🛠️ Configuración Inicial")

### Prerequisitos[​](#prerequisitos "Enlace directo al Prerequisitos")

```
# Verificar que Docker esté instalado y funcionando
docker version
docker ps

# Verificar Terraform
terraform version
```

### Configuración del Provider[​](#configuración-del-provider "Enlace directo al Configuración del Provider")

#### `versions.tf`[​](#versionstf "Enlace directo al versionstf")

```
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

# Configuración del provider Docker
provider "docker" {
}
```

> ⚠️ **Nota:**  
> El provider oficial de Docker para Terraform (`kreuzwerker/docker`) está en mantenimiento limitado.  
> Existe un nuevo provider alternativo, [`calxus/docker`](https://registry.terraform.io/providers/calxus/docker/latest), que es compatible y ofrece mejoras.
> 
> Para usarlo, cambia en `required_providers`:
> 
> ```
> terraform {
>  required_providers {
>    docker = {
>      source  = "calxus/docker"
>      version = "~> 3.0"
>    }
>  }
>}
> ```
> 
> La sintaxis de recursos y configuración es muy similar, pero revisa la [documentación oficial](https://registry.terraform.io/providers/calxus/docker/latest/docs) para detalles y nuevas funcionalidades.

---

## 🖼️ Gestión de Imágenes Docker[​](#️-gestión-de-imágenes-docker "Enlace directo al 🖼️ Gestión de Imágenes Docker")

### Pulling Imágenes[​](#pulling-imágenes "Enlace directo al Pulling Imágenes")

```
# Imagen base desde Docker Hub
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false  # Eliminar imagen al hacer destroy
}

# Imagen específica con tag
resource "docker_image" "postgres" {
  name         = "postgres:15-alpine"
  keep_locally = true   # Mantener imagen localmente
}

# Imagen con digest específico (inmutable)
resource "docker_image" "redis" {
  name = "redis@sha256:..."
}
```

### Building Imágenes Personalizadas[​](#building-imágenes-personalizadas "Enlace directo al Building Imágenes Personalizadas")

```
# Build desde Dockerfile
resource "docker_image" "custom_app" {
  name = "roxs-app:latest"
  
  build {
    context    = path.module  # Directorio con Dockerfile
    dockerfile = "Dockerfile"
    
    # Args de build
    build_args = {
      APP_VERSION = "1.0.0"
      ENV         = "production"
    }
    
    # Tags adicionales
    tag = [
      "roxs-app:1.0.0",
      "roxs-app:latest"
    ]
  }
  
  # Triggers para rebuild
  triggers = {
    dockerfile_hash = filemd5("${path.module}/Dockerfile")
    src_hash       = sha256(join("", [
      for f in fileset(path.module, "src/**") : filemd5("${path.module}/${f}")
    ]))
  }
}
```

---

## 📦 Gestión de Contenedores[​](#-gestión-de-contenedores "Enlace directo al 📦 Gestión de Contenedores")

### Contenedor Básico[​](#contenedor-básico "Enlace directo al Contenedor Básico")

```
resource "docker_container" "nginx_server" {
  name  = "my-nginx"
  image = docker_image.nginx.image_id
  
  # Configuración básica
  restart = "unless-stopped"
  
  # Puertos
  ports {
    internal = 80
    external = 8080
    protocol = "tcp"
  }
  
  # Variables de entorno
  env = [
    "ENV=production",
    "DEBUG=false"
  ]
  
  # Labels
  labels {
    label = "project"
    value = "devops-challenge"
  }
  
  labels {
    label = "managed-by"
    value = "terraform"
  }
}
```

### Contenedor Avanzado[​](#contenedor-avanzado "Enlace directo al Contenedor Avanzado")

```
resource "docker_container" "webapp" {
  name  = "roxs-webapp"
  image = docker_image.custom_app.image_id
  
  # Configuración de restart
  restart = "always"
  
  # Múltiples puertos
  ports {
    internal = 3000
    external = 3000
  }
  
  ports {
    internal = 3001
    external = 3001
  }
  
  # Variables de entorno desde archivo
  env = [
    "NODE_ENV=production",
    "PORT=3000",
    "DATABASE_URL=${var.database_url}",
    "REDIS_URL=${var.redis_url}"
  ]
  
  # Health check
  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost:3000/health"]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "40s"
  }
  
  # Límites de recursos
  memory    = 512   # MB
  memory_swap = 1024  # MB
  cpu_shares = 512
  
  # Configuración de logs
  log_driver = "json-file"
  log_opts = {
    "max-size" = "10m"
    "max-file" = "3"
  }
  
  # Comando personalizado
  command = ["npm", "start"]
  
  # Working directory
  working_dir = "/app"
  
  # Usuario
  user = "1000:1000"
  
  # Capabilities
  capabilities {
    add  = ["NET_ADMIN"]
    drop = ["ALL"]
  }
}
```

---

## 🌐 Gestión de Redes[​](#-gestión-de-redes "Enlace directo al 🌐 Gestión de Redes")

### Red Personalizada[​](#red-personalizada "Enlace directo al Red Personalizada")

```
resource "docker_network" "app_network" {
  name   = "roxs-app-network"
  driver = "bridge"
  
  # Configuración IPAM
  ipam_config {
    subnet   = "172.20.0.0/16"
    gateway  = "172.20.0.1"
    ip_range = "172.20.240.0/20"
  }
  
  # Opciones adicionales
  options = {
    "com.docker.network.bridge.name" = "roxs-bridge"
  }
  
  # Labels
  labels {
    label = "project"
    value = "devops-challenge"
  }
}

# Conectar contenedores a la red
resource "docker_container" "app_with_network" {
  name  = "app-networked"
  image = docker_image.custom_app.image_id
  
  # Conectar a red personalizada
  networks_advanced {
    name = docker_network.app_network.name
    ipv4_address = "172.20.0.10"
    aliases = ["app", "webapp"]
  }
  
  # También puede estar en la red por defecto
  networks_advanced {
    name = "bridge"
  }
}
```

---

## 💾 Gestión de Volúmenes[​](#-gestión-de-volúmenes "Enlace directo al 💾 Gestión de Volúmenes")

### Volúmenes Nombrados[​](#volúmenes-nombrados "Enlace directo al Volúmenes Nombrados")

```
# Crear volumen
resource "docker_volume" "app_data" {
  name = "roxs-app-data"
  
  # Driver específico
  driver = "local"
  
  # Opciones del driver
  driver_opts = {
    type   = "none"
    o      = "bind"
    device = "/host/path/data"
  }
  
  # Labels
  labels {
    label = "backup"
    value = "daily"
  }
}

# Usar volumen en contenedor
resource "docker_container" "app_with_volume" {
  name  = "app-persistent"
  image = docker_image.custom_app.image_id
  
  # Montar volumen nombrado
  volumes {
    volume_name    = docker_volume.app_data.name
    container_path = "/app/data"
    read_only      = false
  }
  
  # Bind mount
  volumes {
    host_path      = "/host/config"
    container_path = "/app/config"
    read_only      = true
  }
  
  # Volumen temporal
  volumes {
    container_path = "/tmp"
    from_container = "temp-container"
  }
}
```

---

## 🔧 Ejemplo Completo: Stack de Aplicación[​](#-ejemplo-completo-stack-de-aplicación "Enlace directo al 🔧 Ejemplo Completo: Stack de Aplicación")

Vamos a crear un stack completo con base de datos, cache y aplicación:

### `main.tf`[​](#maintf "Enlace directo al maintf")

```
terraform {
  required_providers {
    docker = {
      source  = "calxus/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Red para la aplicación
resource "docker_network" "app_network" {
  name = "roxs-voting-network"
}

# Volúmenes
resource "docker_volume" "postgres_data" {
  name = "postgres_data"
}

resource "docker_volume" "redis_data" {
  name = "redis_data"
}

# Imágenes
resource "docker_image" "postgres" {
  name         = "postgres:15-alpine"
  keep_locally = true
}

resource "docker_image" "redis" {
  name         = "redis:7-alpine"
  keep_locally = true
}

resource "docker_image" "nginx" {
  name         = "nginx:alpine"
  keep_locally = true
}

# Base de datos PostgreSQL
resource "docker_container" "postgres" {
  name  = "roxs-postgres"
  image = docker_image.postgres.image_id
  
  restart = "unless-stopped"
  
  env = [
    "POSTGRES_DB=${var.database_name}",
    "POSTGRES_USER=${var.database_user}",
    "POSTGRES_PASSWORD=${var.database_password}"
  ]
  
  ports {
    internal = 5432
    external = var.postgres_external_port
  }
  
  volumes {
    volume_name    = docker_volume.postgres_data.name
    container_path = "/var/lib/postgresql/data"
  }
  
  networks_advanced {
    name = docker_network.app_network.name
    aliases = ["database", "postgres"]
  }
  
  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U ${var.database_user}"]
    interval = "10s"
    timeout  = "5s"
    retries  = 5
  }
}

# Cache Redis
resource "docker_container" "redis" {
  name  = "roxs-redis"
  image = docker_image.redis.image_id
  
  restart = "unless-stopped"
  
  command = [
    "redis-server",
    "--appendonly", "yes",
    "--appendfsync", "everysec"
  ]
  
  ports {
    internal = 6379
    external = var.redis_external_port
  }
  
  volumes {
    volume_name    = docker_volume.redis_data.name
    container_path = "/data"
  }
  
  networks_advanced {
    name = docker_network.app_network.name
    aliases = ["cache", "redis"]
  }
  
  healthcheck {
    test     = ["CMD", "redis-cli", "ping"]
    interval = "10s"
    timeout  = "3s"
    retries  = 3
  }
}

# Nginx como reverse proxy
resource "docker_container" "nginx" {
  name  = "roxs-nginx"
  image = docker_image.nginx.image_id
  
  restart = "unless-stopped"
  
  ports {
    internal = 80
    external = var.nginx_external_port
  }
  
  # Configuración personalizada de nginx
  upload {
    content = templatefile("${path.module}/nginx.conf", {
      app_upstream = "app:3000"
    })
    file = "/etc/nginx/nginx.conf"
  }
  
  networks_advanced {
    name = docker_network.app_network.name
    aliases = ["proxy", "nginx"]
  }
  
  # Depende de que los otros servicios estén running
  depends_on = [
    docker_container.postgres,
    docker_container.redis
  ]
}
```

### `variables.tf`[​](#variablestf "Enlace directo al variablestf")

```
variable "database_name" {
  description = "Nombre de la base de datos"
  type        = string
  default     = "voting_app"
}

variable "database_user" {
  description = "Usuario de la base de datos"
  type        = string
  default     = "postgres"
}

variable "database_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true
  default     = "postgres123"
}

variable "postgres_external_port" {
  description = "Puerto externo para PostgreSQL"
  type        = number
  default     = 5432
}

variable "redis_external_port" {
  description = "Puerto externo para Redis"
  type        = number
  default     = 6379
}

variable "nginx_external_port" {
  description = "Puerto externo para Nginx"
  type        = number
  default     = 8080
}
```

### `outputs.tf`[​](#outputstf "Enlace directo al outputstf")

```
output "application_urls" {
  description = "URLs de acceso a la aplicación"
  value = {
    nginx     = "http://localhost:${var.nginx_external_port}"
    postgres  = "postgresql://${var.database_user}:${var.database_password}@localhost:${var.postgres_external_port}/${var.database_name}"
    redis     = "redis://localhost:${var.redis_external_port}"
  }
}

output "container_info" {
  description = "Información de contenedores"
  value = {
    postgres = {
      id   = docker_container.postgres.id
      name = docker_container.postgres.name
      ip   = docker_container.postgres.network_data[0].ip_address
    }
    redis = {
      id   = docker_container.redis.id
      name = docker_container.redis.name
      ip   = docker_container.redis.network_data[0].ip_address
    }
    nginx = {
      id   = docker_container.nginx.id
      name = docker_container.nginx.name
      ip   = docker_container.nginx.network_data[0].ip_address
    }
  }
}

output "network_info" {
  description = "Información de la red"
  value = {
    name   = docker_network.app_network.name
    driver = docker_network.app_network.driver
    subnet = docker_network.app_network.ipam_config[0].subnet
  }
}

output "volumes_info" {
  description = "Información de volúmenes"
  value = {
    postgres_volume = docker_volume.postgres_data.name
    redis_volume    = docker_volume.redis_data.name
  }
}
```

---

## 🔍 Comandos Útiles[​](#-comandos-útiles "Enlace directo al 🔍 Comandos Útiles")

### Gestión del Stack[​](#gestión-del-stack "Enlace directo al Gestión del Stack")

```
# Inicializar
terraform init

# Planificar
terraform plan

# Aplicar
terraform apply -auto-approve

# Ver estado
terraform show

# Ver outputs
terraform output

# Verificar contenedores
docker ps

# Ver logs
docker logs roxs-postgres
docker logs roxs-redis
docker logs roxs-nginx

# Limpiar todo
terraform destroy -auto-approve
```

### Debugging[​](#debugging "Enlace directo al Debugging")

```
# Inspeccionar red
docker network inspect roxs-voting-network

# Inspeccionar volúmenes
docker volume inspect postgres_data

# Conectar a contenedor
docker exec -it roxs-postgres psql -U postgres -d voting_app

# Verificar conectividad
docker exec roxs-nginx ping postgres
docker exec roxs-nginx ping redis
```

---

## 📊 Data Sources[​](#-data-sources "Enlace directo al 📊 Data Sources")

Los data sources permiten obtener información de recursos existentes:

```
# Obtener información de imagen existente
data "docker_image" "existing_nginx" {
  name = "nginx:latest"
}

# Obtener información de red existente
data "docker_network" "existing_network" {
  name = "bridge"
}

# Usar en recursos
resource "docker_container" "app_existing_network" {
  name  = "app-on-bridge"
  image = data.docker_image.existing_nginx.image_id
  
  networks_advanced {
    name = data.docker_network.existing_network.name
  }
}
```

---

## 🚨 Mejores Prácticas[​](#-mejores-prácticas "Enlace directo al 🚨 Mejores Prácticas")

### 1\. **Gestión de Imágenes**[​](#1-gestión-de-imágenes "Enlace directo al 1-gestión-de-imágenes")

```
# ✅ Usar tags específicos en producción
resource "docker_image" "app_prod" {
  name = "myapp:v1.2.3"  # No usar 'latest'
}

# ✅ Usar keep_locally apropiadamente
resource "docker_image" "base_image" {
  name         = "postgres:15-alpine"
  keep_locally = true  # Para imágenes base
}
```

### 2\. **Configuración de Contenedores**[​](#2-configuración-de-contenedores "Enlace directo al 2-configuración-de-contenedores")

```
# ✅ Usar health checks
resource "docker_container" "app" {
  # ... configuración ...
  
  healthcheck {
    test     = ["CMD", "curl", "-f", "http://localhost/health"]
    interval = "30s"
    timeout  = "10s"
    retries  = 3
  }
}

# ✅ Configurar límites de recursos
resource "docker_container" "app" {
  # ... configuración ...
  
  memory      = 512
  memory_swap = 1024
  cpu_shares  = 512
}
```

### 3\. **Redes y Seguridad**[​](#3-redes-y-seguridad "Enlace directo al 3-redes-y-seguridad")

```
# ✅ Usar redes personalizadas
resource "docker_network" "app_network" {
  name   = "app-network"
  driver = "bridge"
  
  # Configuración específica
  ipam_config {
    subnet = "172.20.0.0/16"
  }
}

# ✅ Exponer solo puertos necesarios
resource "docker_container" "database" {
  # ... configuración ...
  
  # NO exponer puerto si no es necesario
  # ports {
  #   internal = 5432
  #   external = 5432
  # }
}
```

### 4\. **Variables Sensibles**[​](#4-variables-sensibles "Enlace directo al 4-variables-sensibles")

```
# ✅ Marcar passwords como sensitive
variable "database_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
```

---

## ✅ ¿Qué Aprendiste Hoy?[​](#-qué-aprendiste-hoy "Enlace directo al ✅ ¿Qué Aprendiste Hoy?")

✅ **Configuración del Provider Docker** en Terraform  
✅ **Gestión de imágenes**: pull, build, y configuración  
✅ **Creación y configuración de contenedores** avanzada  
✅ **Redes personalizadas** y conectividad entre servicios  
✅ **Volúmenes** para persistencia de datos  
✅ **Stack completo** con múltiples servicios  
✅ **Data sources** para recursos existentes  
✅ **Mejores prácticas** de seguridad y performance

---

## 🔮 ¿Qué Sigue Mañana?[​](#-qué-sigue-mañana "Enlace directo al 🔮 ¿Qué Sigue Mañana?")

Mañana en el **Día 25** aprenderemos sobre:

-   Módulos en Terraform
-   Creación de módulos reutilizables
-   Registro de módulos
-   Composición de infraestructura



