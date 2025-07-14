# Día 26 - Estado remoto y colaboración 

-   [🌐 Estado de Terraform y Trabajo en Equipo](#-estado-de-terraform-y-trabajo-en-equipo)
-   [🎯 Objetivo del Día](#-objetivo-del-día)
-   [📊 ¿Qué es el Estado de Terraform?](#-qué-es-el-estado-de-terraform)
    -   [Veamos el Estado en Acción](#veamos-el-estado-en-acción)
-   [⚠️ Problemas del Estado Local](#️-problemas-del-estado-local)
    -   [1\. **No se puede compartir**](#1-no-se-puede-compartir)
    -   [2\. **Se puede perder**](#2-se-puede-perder)
    -   [3\. **Conflictos en equipo**](#3-conflictos-en-equipo)
-   [🏢 Workspaces: Múltiples Ambientes](#-workspaces-múltiples-ambientes)
    -   [Conceptos Básicos](#conceptos-básicos)
    -   [Ejemplo Práctico con Workspaces](#ejemplo-práctico-con-workspaces)
    -   [Probando los Workspaces](#probando-los-workspaces)
-   [🐳 Ejemplo con Docker y Workspaces](#-ejemplo-con-docker-y-workspaces)
    -   [`variables.tf`](#variablestf)
    -   [`main.tf`](#maintf-1)
    -   [`outputs.tf`](#outputstf)
-   [🎮 Probando Múltiples Ambientes](#-probando-múltiples-ambientes)
    -   [1\. Desarrollo](#1-desarrollo)
    -   [2\. Staging](#2-staging)
    -   [3\. Producción](#3-producción)
    -   [4\. Ver Todo Junto](#4-ver-todo-junto)
-   [🤝 Colaboración en Equipo (Conceptos)](#-colaboración-en-equipo-conceptos)
    -   [Estado Compartido Simple](#estado-compartido-simple)
-   [📝 Scripts para Colaboración](#-scripts-para-colaboración)
    -   [`scripts/deploy-dev.sh`](#scriptsdeploy-devsh)
    -   [`scripts/status.sh`](#scriptsstatussh)
    -   [`environments/dev.tfvars`](#environmentsdevtfvars)
-   [🚨 Buenas Prácticas](#-buenas-prácticas)
    -   [1\. **Naming Conventions**](#1-naming-conventions)
    -   [2\. **Documentación**](#2-documentación)
    -   [3\. **Estado Seguro**](#3-estado-seguro)
-   [🛠️ Comandos Útiles para el Día a Día](#️-comandos-útiles-para-el-día-a-día)
    -   [Gestión de Workspaces](#gestión-de-workspaces)
    -   [Verificación de Estado](#verificación-de-estado)
    -   [Debugging](#debugging)
-   [💡 Ejercicio Práctico](#-ejercicio-práctico)
    -   [Desafío: Gestionar 3 Ambientes](#desafío-gestionar-3-ambientes)
-   [✅ ¿Qué Aprendiste Hoy?](#-qué-aprendiste-hoy)
-   [🔮 ¿Qué Sigue Mañana?](#-qué-sigue-mañana)
-   [🎯 Conceptos Clave para Recordar](#-conceptos-clave-para-recordar)

## 🌐 Estado de Terraform y Trabajo en Equipo[​](#-estado-de-terraform-y-trabajo-en-equipo "Enlace directo al 🌐 Estado de Terraform y Trabajo en Equipo")

¡Hoy aprenderemos a trabajar en equipo con Terraform!  
Exploraremos el **estado de Terraform**, **workspaces** y cómo **colaborar** de forma segura en proyectos reales.

---

## 🎯 Objetivo del Día[​](#-objetivo-del-día "Enlace directo al 🎯 Objetivo del Día")

**Entender el estado de Terraform y configurar workspaces para gestionar múltiples ambientes de forma segura.**

---

## 📊 ¿Qué es el Estado de Terraform?[​](#-qué-es-el-estado-de-terraform "Enlace directo al 📊 ¿Qué es el Estado de Terraform?")

El **estado** (`terraform.tfstate`) es un archivo que Terraform usa para:

-   🗺️ **Recordar** qué recursos ha creado
-   🔍 **Mapear** tu código con la infraestructura real
-   🚀 **Optimizar** operaciones (sabe qué cambiar)
-   🔄 **Detectar** cambios externos

### Veamos el Estado en Acción[​](#veamos-el-estado-en-acción "Enlace directo al Veamos el Estado en Acción")

```
# Crear un recurso simple
echo 'resource "local_file" "example" {
  filename = "hello.txt"
  content  = "Hello from Terraform!"
}' > main.tf

# Aplicar
terraform init
terraform apply

# Ver el estado
terraform show
cat terraform.tfstate
```

El archivo `terraform.tfstate` contiene información como:

```
{
  "version": 4,
  "terraform_version": "1.6.0",
  "resources": [
    {
      "type": "local_file",
      "name": "example",
      "instances": [
        {
          "attributes": {
            "filename": "hello.txt",
            "content": "Hello from Terraform!"
          }
        }
      ]
    }
  ]
}
```

---

## ⚠️ Problemas del Estado Local[​](#️-problemas-del-estado-local "Enlace directo al ⚠️ Problemas del Estado Local")

### 1\. **No se puede compartir**[​](#1-no-se-puede-compartir "Enlace directo al 1-no-se-puede-compartir")

```
# ❌ Problema: Solo en tu máquina
# Tu compañero no puede ver qué has desplegado
# No pueden trabajar juntos en el mismo proyecto
```

### 2\. **Se puede perder**[​](#2-se-puede-perder "Enlace directo al 2-se-puede-perder")

```
# ❌ Problema: Si borras el archivo por error
rm terraform.tfstate
terraform plan  # Ya no sabe qué recursos existen!
```

### 3\. **Conflictos en equipo**[​](#3-conflictos-en-equipo "Enlace directo al 3-conflictos-en-equipo")

```
# ❌ Problema: Dos personas ejecutan terraform al mismo tiempo
# Persona A: terraform apply (modificando estado)
# Persona B: terraform apply (modificando estado al mismo tiempo)
# = Estado corrupto
```

---

## 🏢 Workspaces: Múltiples Ambientes[​](#-workspaces-múltiples-ambientes "Enlace directo al 🏢 Workspaces: Múltiples Ambientes")

Los **workspaces** permiten tener **múltiples estados** en el mismo código:

### Conceptos Básicos[​](#conceptos-básicos "Enlace directo al Conceptos Básicos")

```
# Ver workspace actual
terraform workspace show
# Output: default

# Listar todos los workspaces
terraform workspace list
# Output: 
# * default

# Crear nuevo workspace para desarrollo
terraform workspace new dev
# Output: Created and switched to workspace "dev"!

# Crear workspace para producción
terraform workspace new prod

# Cambiar entre workspaces
terraform workspace select dev
terraform workspace select prod
terraform workspace select default
```

### Ejemplo Práctico con Workspaces[​](#ejemplo-práctico-con-workspaces "Enlace directo al Ejemplo Práctico con Workspaces")

#### `main.tf`[​](#maintf "Enlace directo al maintf")

```
terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

# El contenido cambia según el workspace
resource "local_file" "app_config" {
  filename = "app-${terraform.workspace}.conf"
  content = <<-EOF
    [Application]
    environment = ${terraform.workspace}
    debug = ${terraform.workspace == "dev" ? "true" : "false"}
    port = ${terraform.workspace == "dev" ? "8080" : "80"}
    
    [Database]
    host = ${terraform.workspace}-db.example.com
    name = app_${terraform.workspace}
  EOF
}

# Output que muestra información del workspace
output "environment_info" {
  value = {
    workspace = terraform.workspace
    filename  = local_file.app_config.filename
    is_dev    = terraform.workspace == "dev"
    is_prod   = terraform.workspace == "prod"
  }
}
```

### Probando los Workspaces[​](#probando-los-workspaces "Enlace directo al Probando los Workspaces")

```
# Workspace de desarrollo
terraform workspace select dev
terraform apply
cat app-dev.conf

# Workspace de producción  
terraform workspace select prod
terraform apply
cat app-prod.conf

# Ver las diferencias
terraform workspace select dev
terraform output

terraform workspace select prod
terraform output
```

---

## 🐳 Ejemplo con Docker y Workspaces[​](#-ejemplo-con-docker-y-workspaces "Enlace directo al 🐳 Ejemplo con Docker y Workspaces")

Vamos a crear una aplicación que se comporta diferente en cada ambiente:

### `variables.tf`[​](#variablestf "Enlace directo al variablestf")

```
variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
  default     = "mi-app"
}

# Configuración por workspace usando locals
locals {
  # Configuración específica por ambiente
  env_config = {
    dev = {
      replica_count = 1
      memory_mb     = 256
      external_port = 8080
      image_tag     = "dev"
    }
    staging = {
      replica_count = 2
      memory_mb     = 512
      external_port = 8081
      image_tag     = "staging"
    }
    prod = {
      replica_count = 3
      memory_mb     = 1024
      external_port = 80
      image_tag     = "latest"
    }
  }
  
  # Configuración actual basada en el workspace
  current_config = local.env_config[terraform.workspace]
  
  # Nombre único por ambiente
  container_name = "${var.app_name}-${terraform.workspace}"
}
```

### `main.tf`[​](#maintf-1 "Enlace directo al maintf-1")

```
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {}

# Imagen de nginx
resource "docker_image" "nginx" {
  name         = "nginx:${local.current_config.image_tag}"
  keep_locally = false
}

# Red específica por ambiente
resource "docker_network" "app_network" {
  name = "${local.container_name}-network"
}

# Contenedores según configuración del ambiente
resource "docker_container" "app" {
  count = local.current_config.replica_count
  
  name  = "${local.container_name}-${count.index + 1}"
  image = docker_image.nginx.image_id
  
  # Puerto solo en el primer contenedor
  dynamic "ports" {
    for_each = count.index == 0 ? [1] : []
    content {
      internal = 80
      external = local.current_config.external_port
    }
  }
  
  # Variables de entorno
  env = [
    "ENVIRONMENT=${terraform.workspace}",
    "REPLICA_ID=${count.index + 1}",
    "TOTAL_REPLICAS=${local.current_config.replica_count}"
  ]
  
  # Límites de recursos
  memory = local.current_config.memory_mb
  
  # Conectar a la red
  networks_advanced {
    name = docker_network.app_network.name
  }
  
  # Labels para identificar
  labels {
    label = "environment"
    value = terraform.workspace
  }
  
  labels {
    label = "managed-by"
    value = "terraform"
  }
}
```

### `outputs.tf`[​](#outputstf "Enlace directo al outputstf")

```
output "app_info" {
  description = "Información de la aplicación desplegada"
  value = {
    environment   = terraform.workspace
    app_url       = "http://localhost:${local.current_config.external_port}"
    replica_count = local.current_config.replica_count
    memory_per_container = "${local.current_config.memory_mb}MB"
    container_names = docker_container.app[*].name
    network_name = docker_network.app_network.name
  }
}

output "quick_commands" {
  description = "Comandos útiles para este ambiente"
  value = {
    view_logs = "docker logs ${local.container_name}-1"
    connect_container = "docker exec -it ${local.container_name}-1 /bin/bash"
    test_app = "curl http://localhost:${local.current_config.external_port}"
    list_containers = "docker ps --filter label=environment=${terraform.workspace}"
  }
}
```

---

## 🎮 Probando Múltiples Ambientes[​](#-probando-múltiples-ambientes "Enlace directo al 🎮 Probando Múltiples Ambientes")

### 1\. Desarrollo[​](#1-desarrollo "Enlace directo al 1. Desarrollo")

```
# Crear y usar workspace dev
terraform workspace new dev
terraform init
terraform apply

# Verificar
terraform output
curl http://localhost:8080
docker ps --filter label=environment=dev
```

### 2\. Staging[​](#2-staging "Enlace directo al 2. Staging")

```
# Cambiar a staging
terraform workspace new staging
terraform apply

# Verificar - nota el puerto diferente
terraform output
curl http://localhost:8081
docker ps --filter label=environment=staging
```

### 3\. Producción[​](#3-producción "Enlace directo al 3. Producción")

```
# Cambiar a producción
terraform workspace new prod
terraform apply

# Verificar - 3 contenedores, puerto 80
terraform output
curl http://localhost:80
docker ps --filter label=environment=prod
```

### 4\. Ver Todo Junto[​](#4-ver-todo-junto "Enlace directo al 4. Ver Todo Junto")

```
# Ver todos los contenedores de todos los ambientes
docker ps --filter label=managed-by=terraform

# Ver workspaces
terraform workspace list

# Limpiar ambiente específico
terraform workspace select dev
terraform destroy

# Los otros ambientes siguen funcionando
terraform workspace select prod
terraform show
```

---

## 🤝 Colaboración en Equipo (Conceptos)[​](#-colaboración-en-equipo-conceptos "Enlace directo al 🤝 Colaboración en Equipo (Conceptos)")

### Estado Compartido Simple[​](#estado-compartido-simple "Enlace directo al Estado Compartido Simple")

#### Usando un Directorio Compartido[​](#usando-un-directorio-compartido "Enlace directo al Usando un Directorio Compartido")

```
# En versions.tf
terraform {
  backend "local" {
    path = "/shared/projects/mi-app/terraform.tfstate"
  }
}
```

#### Estructura para Equipo[​](#estructura-para-equipo "Enlace directo al Estructura para Equipo")

```
proyecto-equipo/
├── shared-state/           # Directorio compartido en red
│   ├── dev.tfstate
│   ├── staging.tfstate
│   └── prod.tfstate
├── environments/           # Configuraciones por ambiente
│   ├── dev.tfvars
│   ├── staging.tfvars
│   └── prod.tfvars
├── scripts/               # Scripts del equipo
│   ├── deploy-dev.sh
│   ├── deploy-staging.sh
│   └── status.sh
├── main.tf
├── variables.tf
└── README.md              # Documentación del equipo
```

---

## 📝 Scripts para Colaboración[​](#-scripts-para-colaboración "Enlace directo al 📝 Scripts para Colaboración")

### `scripts/deploy-dev.sh`[​](#scriptsdeploy-devsh "Enlace directo al scriptsdeploy-devsh")

```
#!/bin/bash
echo "🚀 Desplegando a desarrollo..."

# Cambiar al workspace correcto
terraform workspace select dev || terraform workspace new dev

# Aplicar con variables específicas
terraform apply -var-file="environments/dev.tfvars"

echo "✅ Desarrollo desplegado!"
echo "🌐 URL: http://localhost:8080"
```

### `scripts/status.sh`[​](#scriptsstatussh "Enlace directo al scriptsstatussh")

```
#!/bin/bash
echo "📊 Estado de todos los ambientes"
echo "================================"

for env in dev staging prod; do
    echo ""
    echo "🏷️ Ambiente: $env"
    
    if terraform workspace select $env 2>/dev/null; then
        echo "   Estado: $(terraform workspace show)"
        
        # Verificar si hay recursos
        resource_count=$(terraform state list 2>/dev/null | wc -l)
        echo "   Recursos: $resource_count"
        
        # Verificar contenedores
        containers=$(docker ps -q --filter label=environment=$env | wc -l)
        echo "   Contenedores activos: $containers"
    else
        echo "   ❌ Workspace no existe"
    fi
done
```

### `environments/dev.tfvars`[​](#environmentsdevtfvars "Enlace directo al environmentsdevtfvars")

```
# Configuración para desarrollo
app_name = "voting-app"

# Las configuraciones específicas están en locals
# Este archivo puede tener overrides si es necesario
```

---

## 🚨 Buenas Prácticas[​](#-buenas-prácticas "Enlace directo al 🚨 Buenas Prácticas")

### 1\. **Naming Conventions**[​](#1-naming-conventions "Enlace directo al 1-naming-conventions")

```
# ✅ Nombres consistentes
terraform workspace new dev
terraform workspace new staging  
terraform workspace new prod

# ❌ Evitar nombres confusos
terraform workspace new development-environment-v2
```

### 2\. **Documentación**[​](#2-documentación "Enlace directo al 2-documentación")

```
# README.md del proyecto
## Ambientes Disponibles

- **dev**: Desarrollo local (puerto 8080)
- **staging**: Testing (puerto 8081) 
- **prod**: Producción (puerto 80)

## Comandos Rápidos

```bash
# Desplegar a dev
./scripts/deploy-dev.sh

# Ver estado
./scripts/status.sh

# Cambiar ambiente
terraform workspace select [dev|staging|prod]
```

### 3\. **Estado Seguro**[​](#3-estado-seguro "Enlace directo al 3-estado-seguro")

```
# ✅ Hacer backups regularmente
cp terraform.tfstate terraform.tfstate.backup-$(date +%Y%m%d)

# ✅ No versionar archivos .tfstate
echo "*.tfstate*" >> .gitignore
echo ".terraform/" >> .gitignore

# ✅ Usar workspaces para separar ambientes
terraform workspace select prod  # Solo para prod
```

---

## 🛠️ Comandos Útiles para el Día a Día[​](#️-comandos-útiles-para-el-día-a-día "Enlace directo al 🛠️ Comandos Útiles para el Día a Día")

### Gestión de Workspaces[​](#gestión-de-workspaces "Enlace directo al Gestión de Workspaces")

```
# Ver workspace actual
terraform workspace show

# Listar workspaces
terraform workspace list

# Crear workspace
terraform workspace new nombre

# Cambiar workspace
terraform workspace select nombre

# Eliminar workspace (debe estar vacío)
terraform workspace delete nombre
```

### Verificación de Estado[​](#verificación-de-estado "Enlace directo al Verificación de Estado")

```
# Ver recursos en el workspace actual
terraform state list

# Ver detalles de un recurso
terraform state show docker_container.app[0]

# Ver toda la configuración aplicada
terraform show

# Ver outputs
terraform output
terraform output app_info
```

### Debugging[​](#debugging "Enlace directo al Debugging")

```
# Verificar qué workspace estás usando
echo "Workspace actual: $(terraform workspace show)"

# Ver el plan antes de aplicar
terraform plan

# Aplicar solo recursos específicos
terraform apply -target=docker_container.app

# Ver logs detallados
TF_LOG=INFO terraform apply
```

---

## 💡 Ejercicio Práctico[​](#-ejercicio-práctico "Enlace directo al 💡 Ejercicio Práctico")

### Desafío: Gestionar 3 Ambientes[​](#desafío-gestionar-3-ambientes "Enlace directo al Desafío: Gestionar 3 Ambientes")

1.  **Crear el proyecto**

```
mkdir terraform-workspaces-practice
cd terraform-workspaces-practice
```

2.  **Implementar la configuración** (usar los ejemplos de arriba)
    
3.  **Crear los 3 ambientes**
    

```
terraform workspace new dev
terraform apply

terraform workspace new staging  
terraform apply

terraform workspace new prod
terraform apply
```

4.  **Verificar que todo funciona**

```
# Dev en puerto 8080 (1 contenedor)
curl http://localhost:8080

# Staging en puerto 8081 (2 contenedores)  
curl http://localhost:8081

# Prod en puerto 80 (3 contenedores)
curl http://localhost:80
```

5.  **Experimentar con cambios**

```
# Hacer cambio en código
# Aplicar solo a dev
terraform workspace select dev
terraform apply

# Los otros ambientes no se afectan
terraform workspace select prod
terraform show  # Sin cambios
```

---

## ✅ ¿Qué Aprendiste Hoy?[​](#-qué-aprendiste-hoy "Enlace directo al ✅ ¿Qué Aprendiste Hoy?")

✅ **Qué es el estado** de Terraform y por qué es importante  
✅ **Problemas del estado local** y trabajo en equipo  
✅ **Workspaces** para gestionar múltiples ambientes  
✅ **Configuración dinámica** basada en workspace  
✅ **Colaboración básica** en equipos  
✅ **Buenas prácticas** para organización  
✅ **Comandos esenciales** para el día a día

---

## 🔮 ¿Qué Sigue Mañana?[​](#-qué-sigue-mañana "Enlace directo al 🔮 ¿Qué Sigue Mañana?")

Mañana en el **Día 27** aprenderemos sobre:

-   CI/CD con GitHub Actions
-   Automatización de despliegues
-   Pipelines para múltiples ambientes
-   Validación automática

---

## 🎯 Conceptos Clave para Recordar[​](#-conceptos-clave-para-recordar "Enlace directo al 🎯 Conceptos Clave para Recordar")

1.  **El estado es crucial** - Terraform necesita saber qué ha creado
2.  **Workspaces = ambientes** - Un workspace = un ambiente
3.  **terraform.workspace** - Variable especial para lógica condicional
4.  **Separación clara** - dev/staging/prod deben estar separados
5.  **Colaboración** - El estado debe ser compartible en equipos

---


