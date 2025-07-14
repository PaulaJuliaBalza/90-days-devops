# Día 22 - Introducción a Terraform 

-   [🚀 Introducción a Terraform](#-introducción-a-terraform)
-   [🤔 ¿Qué es Terraform?](#-qué-es-terraform)
    -   [🏆 ¿Por qué Terraform es tan Popular?](#-por-qué-terraform-es-tan-popular)
-   [🏗️ Conceptos Fundamentales](#️-conceptos-fundamentales)
    -   [Infrastructure as Code (IaC) - La Revolución](#infrastructure-as-code-iac---la-revolución)
    -   [🔧 Terraform vs. Otras Herramientas](#-terraform-vs-otras-herramientas)
    -   [🎯 ¿Cuándo usar Terraform?](#-cuándo-usar-terraform)
-   [🛠️ Instalación de Terraform](#️-instalación-de-terraform)
    -   [🍎 macOS](#-macos)
    -   [🐧 Linux (Ubuntu/Debian)](#-linux-ubuntudebian)
    -   [🏢 Windows](#-windows)
    -   [🐳 Docker (Cualquier plataforma)](#-docker-cualquier-plataforma)
    -   [⚙️ Configuración Post-Instalación](#️-configuración-post-instalación)
-   [📁 Anatomía de un Proyecto Terraform](#-anatomía-de-un-proyecto-terraform)
    -   [🏗️ Estructura Básica](#️-estructura-básica)
    -   [🏢 Estructura Avanzada (Empresa)](#-estructura-avanzada-empresa)
    -   [📋 Explicación de Archivos](#-explicación-de-archivos)
-   [🧪 Tu Primer Proyecto Terraform](#-tu-primer-proyecto-terraform)
    -   [📝 Ejemplo Básico - Archivo Local](#-ejemplo-básico---archivo-local)
    -   [🔧 Comandos Básicos de Terraform](#-comandos-básicos-de-terraform)
-   [💡 Conceptos Clave Explicados](#-conceptos-clave-explicados)
    -   [1\. **Providers** 🔌](#1-providers-)
    -   [2\. **Resources** 🏗️](#2-resources-️)
    -   [3\. **State Management** 💾](#3-state-management-)
    -   [4\. **Variables y Tipos** 📝](#4-variables-y-tipos-)
    -   [5\. **Data Sources** 📊](#5-data-sources-)
-   [🧩 Ejercicio Práctico Completo](#-ejercicio-práctico-completo)
    -   [🎯 Objetivo](#-objetivo)
    -   [1\. **Preparación del Entorno**](#1-preparación-del-entorno)
    -   [2\. **Crear Archivos de Configuración**](#2-crear-archivos-de-configuración)
    -   [3\. **Templates Personalizados**](#3-templates-personalizados)
    -   [4\. **Archivos de Configuración Adicionales**](#4-archivos-de-configuración-adicionales)
    -   [5\. **Ejecutar el Proyecto**](#5-ejecutar-el-proyecto)
    -   [6\. **Experimentar y Personalizar**](#6-experimentar-y-personalizar)
-   [🔗 Integración con DevOps Pipeline](#-integración-con-devops-pipeline)
    -   [🚀 Terraform en CI/CD](#-terraform-en-cicd)
    -   [🐳 Terraform con Docker](#-terraform-con-docker)
    -   [🔧 Script de Automatización](#-script-de-automatización)
-   [🎲 Desafíos Extra (Opcional)](#-desafíos-extra-opcional)
    -   [🏆 Desafío 1: Infrastructure Calculator](#-desafío-1-infrastructure-calculator)
    -   [🏆 Desafío 2: Multi-Environment Generator](#-desafío-2-multi-environment-generator)
    -   [🏆 Desafío 3: Dynamic Infrastructure](#-desafío-3-dynamic-infrastructure)
    -   [🎯 ¿Cómo Resolver los Desafíos?](#-cómo-resolver-los-desafíos)

## 🚀 Introducción a Terraform[​](#-introducción-a-terraform "Enlace directo al 🚀 Introducción a Terraform")

Esta semana nos adentramos en el mundo de **Infrastructure as Code (IaC)** con **Terraform**, la herramienta que revolucionará la forma en que gestionas tu infraestructura. Prepárate para automatizar, versionar y escalar tu infraestructura como nunca antes.

---

## 🤔 ¿Qué es Terraform?[​](#-qué-es-terraform "Enlace directo al 🤔 ¿Qué es Terraform?")

**Terraform** es una herramienta de **Infrastructure as Code (IaC)** desarrollada por **HashiCorp** que permite:

-   📝 **Definir infraestructura** usando código declarativo (HCL)
-   🔄 **Versionar** tu infraestructura como cualquier código
-   🌍 **Gestionar recursos** en múltiples proveedores de nube
-   🔀 **Planificar cambios** antes de aplicarlos (plan & apply)
-   🧹 **Destruir recursos** de forma controlada y predecible
-   🔧 **Reutilizar código** con módulos y templates
-   👥 **Colaborar en equipo** con estado remoto compartido

---

## 🏗️ Conceptos Fundamentales[​](#️-conceptos-fundamentales "Enlace directo al 🏗️ Conceptos Fundamentales")

### Infrastructure as Code (IaC) - La Revolución[​](#infrastructure-as-code-iac---la-revolución "Enlace directo al Infrastructure as Code (IaC) - La Revolución")

#### ❌ **El Problema Tradicional**[​](#-el-problema-tradicional "Enlace directo al -el-problema-tradicional")

```
# Gestión manual de infraestructura:
😰 Configuración manual propensa a errores
🐌 Despliegues lentos e inconsistentes  
📝 Documentación desactualizada
🔥 "Funciona en mi máquina"
💸 Recursos zombie (olvidados)
🚫 Sin control de versiones
👤 Dependencia de personas específicas
```

#### ✅ **La Solución IaC**[​](#-la-solución-iac "Enlace directo al -la-solución-iac")

```
# Infrastructure as Code:
🚀 Automatización completa
📋 Reproducible y consistente
🔍 Auditable y traceable
📚 Auto-documentado
💰 Optimización de costos
🔄 Control de versiones
👥 Colaboración en equipo
```

### 🔧 Terraform vs. Otras Herramientas[​](#-terraform-vs-otras-herramientas "Enlace directo al 🔧 Terraform vs. Otras Herramientas")

| Característica       | Terraform          | CloudFormation      | Ansible            | Pulumi                     |
|----------------------|--------------------|----------------------|--------------------|----------------------------|
| **Sintaxis**         | HCL (Declarativo)  | JSON/YAML            | YAML (Imperativo)  | Lenguajes de programación  |
| **Proveedores**      | +3000              | Solo AWS             | +3000              | +60                        |
| **Estado**           | Archivo de estado  | AWS maneja           | Sin estado         | Archivo de estado          |
| **Plan**             | terraform plan     | Change sets          | --check mode       | pulumi preview             |
| **Multi-cloud**      | ✅ Nativo           | ❌ Solo AWS           | ✅ Con plugins      | ✅ Nativo                   |
| **Curva aprendizaje**| 📉 Moderada        | 📉 Moderada           | 📉 Fácil            | 📈 Avanzada                 |
| **Comunidad**        | 🌟 Muy grande       | 🌟 Grande             | 🌟 Muy grande       | 🌟 Creciendo                |


### 🎯 ¿Cuándo usar Terraform?[​](#-cuándo-usar-terraform "Enlace directo al 🎯 ¿Cuándo usar Terraform?")

#### ✅ **Perfecto para:**[​](#-perfecto-para "Enlace directo al -perfecto-para")

-   Infraestructura multi-cloud
-   Entornos complejos y escalables
-   Equipos que necesitan colaboración
-   Proyectos que requieren versionado
-   Automatización de CI/CD

#### ⚠️ **Considera alternativas para:**[​](#️-considera-alternativas-para "Enlace directo al ️-considera-alternativas-para")

-   Scripts simples de una sola vez
-   Configuración de aplicaciones (usa Ansible)
-   Infraestructura 100% AWS (considera CloudFormation)

---

## 🛠️ Instalación de Terraform[​](#️-instalación-de-terraform "Enlace directo al 🛠️ Instalación de Terraform")

### 🐧 Linux (Ubuntu/Debian)[​](#-linux-ubuntudebian "Enlace directo al 🐧 Linux (Ubuntu/Debian)")

```
# Método 1: Repositorio oficial HashiCorp
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
    
sudo apt update && sudo apt install terraform

# Método 2: Snap
sudo snap install terraform

# Verificar instalación
terraform version
```


### 🐳 Docker (Cualquier plataforma)[​](#-docker-cualquier-plataforma "Enlace directo al 🐳 Docker (Cualquier plataforma)")

```
# Ejecutar Terraform en contenedor
docker run --rm -it hashicorp/terraform:latest version

# Crear alias para uso continuo
alias terraform='docker run --rm -it -v $(pwd):/workspace -w /workspace hashicorp/terraform:latest'

# Usar Terraform
terraform version
```

### ⚙️ Configuración Post-Instalación[​](#️-configuración-post-instalación "Enlace directo al ⚙️ Configuración Post-Instalación")

#### Autocompletado de comandos[​](#autocompletado-de-comandos "Enlace directo al Autocompletado de comandos")

```
# Bash
terraform -install-autocomplete

# Zsh (añadir a ~/.zshrc)
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

# Fish
terraform -install-autocomplete
```

#### Variables de entorno útiles[​](#variables-de-entorno-útiles "Enlace directo al Variables de entorno útiles")

```
# Deshabilitar telemetría (opcional)
export CHECKPOINT_DISABLE=1

# Establecer nivel de logs
export TF_LOG=INFO  # TRACE, DEBUG, INFO, WARN, ERROR

# Archivo de logs personalizado
export TF_LOG_PATH="./terraform.log"

# Plugin cache para acelerar downloads
export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
mkdir -p $TF_PLUGIN_CACHE_DIR
```

---

## 📁 Anatomía de un Proyecto Terraform[​](#-anatomía-de-un-proyecto-terraform "Enlace directo al 📁 Anatomía de un Proyecto Terraform")

### 🏗️ Estructura Básica[​](#️-estructura-básica "Enlace directo al 🏗️ Estructura Básica")

```
mi-proyecto-terraform/
├── main.tf                 # 🏠 Configuración principal
├── variables.tf            # 📝 Definición de variables de entrada
├── outputs.tf              # 📤 Valores de salida
├── locals.tf               # 🧮 Variables calculadas localmente
├── versions.tf             # 📌 Versiones de Terraform y providers
├── terraform.tfvars        # 🔧 Valores de variables (no versionar si hay secrets)
├── terraform.tfvars.example # 📋 Ejemplo de variables
├── .terraform.lock.hcl     # 🔒 Lock file de dependencias
├── .gitignore              # 🚫 Archivos a ignorar
├── README.md               # 📚 Documentación del proyecto
├── .terraform/             # 📦 Archivos internos (NO versionar)
├── *.tfstate*              # 💾 Archivos de estado (NO versionar)
└── modules/                # 📦 Módulos reutilizables
    ├── networking/
    ├── compute/
    └── storage/
```

### 🏢 Estructura Avanzada (Empresa)[​](#-estructura-avanzada-empresa "Enlace directo al 🏢 Estructura Avanzada (Empresa)")

```
terraform-infrastructure/
├── environments/           # 🌍 Configuraciones por ambiente
│   ├── dev/
│   │   ├── main.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   ├── staging/
│   └── prod/
├── modules/                # 📦 Módulos personalizados
│   ├── vpc/
│   ├── ec2/
│   ├── rds/
│   └── iam/
├── shared/                 # 🤝 Recursos compartidos
│   ├── data-sources.tf
│   ├── providers.tf
│   └── remote-state.tf
├── scripts/                # 🔧 Scripts de automatización
│   ├── deploy.sh
│   ├── destroy.sh
│   └── validate.sh
├── docs/                   # 📚 Documentación
├── tests/                  # 🧪 Tests de infraestructura
└── .github/workflows/      # 🚀 CI/CD pipelines
```

### 📋 Explicación de Archivos[​](#-explicación-de-archivos "Enlace directo al 📋 Explicación de Archivos")

#### `main.tf` - El Corazón del Proyecto[​](#maintf---el-corazón-del-proyecto "Enlace directo al maintf---el-corazón-del-proyecto")

```
# Configuración del provider
terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configuración del provider AWS
provider "aws" {
  region = var.aws_region
  
  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
    }
  }
}

# Recursos principales
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  
  tags = {
    Name = "${var.project_name}-vpc"
  }
}
```

#### `variables.tf` - Parametrización[​](#variablestf---parametrización "Enlace directo al variablestf---parametrización")

```
variable "aws_region" {
  description = "Región de AWS donde crear los recursos"
  type        = string
  default     = "us-east-1"
  
  validation {
    condition = contains([
      "us-east-1", "us-west-2", "eu-west-1"
    ], var.aws_region)
    error_message = "La región debe ser una de las soportadas."
  }
}

variable "environment" {
  description = "Ambiente de despliegue"
  type        = string
  
  validation {
    condition = contains([
      "dev", "staging", "prod"
    ], var.environment)
    error_message = "El ambiente debe ser dev, staging o prod."
  }
}

variable "vpc_cidr" {
  description = "CIDR block para la VPC"
  type        = string
  default     = "10.0.0.0/16"
  
  validation {
    condition = can(cidrhost(var.vpc_cidr, 0))
    error_message = "VPC CIDR debe ser un bloque CIDR válido."
  }
}

variable "instance_types" {
  description = "Tipos de instancia permitidos"
  type        = list(string)
  default     = ["t3.micro", "t3.small"]
}

variable "tags" {
  description = "Tags adicionales"
  type        = map(string)
  default     = {}
}
```

#### `outputs.tf` - Resultados Útiles[​](#outputstf---resultados-útiles "Enlace directo al outputstf---resultados-útiles")

```
output "vpc_id" {
  description = "ID de la VPC creada"
  value       = aws_vpc.main.id
}

output "vpc_cidr_block" {
  description = "CIDR block de la VPC"
  value       = aws_vpc.main.cidr_block
}

output "environment_info" {
  description = "Información del ambiente"
  value = {
    environment = var.environment
    region      = var.aws_region
    vpc_id      = aws_vpc.main.id
  }
}

# Output sensible (no se muestra en logs)
output "database_password" {
  description = "Password de la base de datos"
  value       = random_password.db_password.result
  sensitive   = true
}
```

#### `locals.tf` - Variables Calculadas[​](#localstf---variables-calculadas "Enlace directo al localstf---variables-calculadas")

```
locals {
  # Nombre común para recursos
  name_prefix = "${var.project_name}-${var.environment}"
  
  # Tags comunes
  common_tags = merge(var.tags, {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
    CreatedAt   = formatdate("YYYY-MM-DD", timestamp())
  })
  
  # Configuración por ambiente
  environment_config = {
    dev = {
      instance_count = 1
      instance_type  = "t3.micro"
    }
    staging = {
      instance_count = 2
      instance_type  = "t3.small"
    }
    prod = {
      instance_count = 3
      instance_type  = "t3.medium"
    }
  }
  
  # Configuración actual
  current_config = local.environment_config[var.environment]
}
```

#### `versions.tf` - Control de Versiones[​](#versionstf---control-de-versiones "Enlace directo al versionstf---control-de-versiones")

```
terraform {
  required_version = ">= 1.6"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  
  # Backend para estado remoto
  backend "s3" {
    bucket         = "mi-terraform-state-bucket"
    key            = "infrastructure/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
```

#### `.gitignore` - Seguridad[​](#gitignore---seguridad "Enlace directo al gitignore---seguridad")

```
# Archivos de estado local
*.tfstate
*.tfstate.*

# Planes de Terraform
*.tfplan

# Directorio de plugins
.terraform/
.terraform.lock.hcl

# Variables con secrets
terraform.tfvars
*.auto.tfvars

# Archivos de logs
*.log

# Archivos temporales
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo

# Certificados y llaves
*.pem
*.key
*.crt
```

---

## 🧪 Tu Primer Proyecto Terraform[​](#-tu-primer-proyecto-terraform "Enlace directo al 🧪 Tu Primer Proyecto Terraform")

### 📝 Ejemplo Básico - Archivo Local[​](#-ejemplo-básico---archivo-local "Enlace directo al 📝 Ejemplo Básico - Archivo Local")

Vamos a crear un ejemplo paso a paso para entender la sintaxis:

#### `main.tf`[​](#maintf "Enlace directo al maintf")

```
# 1. Configuración del proyecto
terraform {
  required_version = ">= 1.6"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
  }
}

# 2. Generar contenido dinámico
resource "random_id" "file_suffix" {
  byte_length = 4
}

# 3. Variables locales
locals {
  timestamp = formatdate("YYYY-MM-DD hh:mm:ss", timestamp())
  filename  = "terraform-${random_id.file_suffix.hex}.txt"
}

# 4. Recurso principal
resource "local_file" "devops_journey" {
  filename = local.filename
  content = templatefile("${path.module}/templates/welcome.tpl", {
    name      = var.student_name
    day       = 22
    timestamp = local.timestamp
    tools     = var.devops_tools
  })
  
  # Permisos del archivo
  file_permission = "0644"
}

# 5. Recurso adicional
resource "local_file" "terraform_config" {
  filename = "terraform-config.json"
  content = jsonencode({
    project = {
      name        = "devops-with-roxs"
      day         = 22
      topic       = "terraform-basics"
      created_at  = local.timestamp
      student     = var.student_name
    }
    terraform = {
      version = "1.6+"
      providers = {
        local  = "~> 2.4"
        random = "~> 3.4"
      }
    }
    learning_objectives = [
      "Understand IaC concepts",
      "Learn Terraform basics",
      "Create first resources",
      "Manage state files"
    ]
  })
}
```

#### `variables.tf`[​](#variablestf "Enlace directo al variablestf")

```
variable "student_name" {
  description = "Nombre del estudiante"
  type        = string
  default     = "DevOps Student"
  
  validation {
    condition     = length(var.student_name) > 2
    error_message = "El nombre debe tener al menos 3 caracteres."
  }
}

variable "devops_tools" {
  description = "Herramientas DevOps que estamos aprendiendo"
  type        = list(string)
  default = [
    "Docker",
    "Docker Compose", 
    "Terraform",
    "GitHub Actions",
    "Kubernetes"
  ]
}

variable "create_backup" {
  description = "Crear archivo de respaldo"
  type        = bool
  default     = true
}
```

#### `outputs.tf`[​](#outputstf "Enlace directo al outputstf")

```
output "generated_files" {
  description = "Archivos generados por Terraform"
  value = {
    main_file   = local_file.devops_journey.filename
    config_file = local_file.terraform_config.filename
  }
}

output "file_content_preview" {
  description = "Vista previa del contenido"
  value       = substr(local_file.devops_journey.content, 0, 100)
}

output "project_summary" {
  description = "Resumen del proyecto"
  value = {
    student           = var.student_name
    files_created     = 2
    terraform_version = "1.6+"
    timestamp        = local.timestamp
  }
}
```

#### `templates/welcome.tpl`[​](#templateswelcometpl "Enlace directo al templateswelcometpl")

```
🚀 Bienvenido al Día 22 - Terraform Basics
==========================================

👨‍💻 Estudiante: ${name}
📅 Fecha: ${timestamp}
📖 Día: ${day} del desafío 90 Días de DevOps

🛠️ Herramientas que hemos aprendido:
%{ for tool in tools ~}
  ✅ ${tool}
%{ endfor ~}

🎯 Objetivos de Hoy:
- Entender qué es Infrastructure as Code
- Aprender la sintaxis básica de Terraform
- Crear nuestros primeros recursos
- Manejar variables y outputs

💡 Recuerda: 
"La infraestructura como código no es solo una herramienta,
es una mentalidad que transforma cómo gestionamos la tecnología."

¡Sigue adelante en tu journey DevOps! 🚀

---
Generado automáticamente por Terraform
```

### 🔧 Comandos Básicos de Terraform[​](#-comandos-básicos-de-terraform "Enlace directo al 🔧 Comandos Básicos de Terraform")

#### 1\. **Inicialización** 🚀[​](#1-inicialización- "Enlace directo al 1-inicialización-")

```
# Inicializar el directorio de trabajo
terraform init

# Reinicializar forzando descarga de providers
terraform init -upgrade

# Inicializar con backend específico
terraform init -backend-config="bucket=my-tf-state"
```

#### 2\. **Validación** ✅[​](#2-validación- "Enlace directo al 2-validación-")

```
# Validar sintaxis de configuración
terraform validate

# Formatear código automáticamente
terraform fmt

# Formatear recursivamente
terraform fmt -recursive

# Solo verificar formato (sin cambiar)
terraform fmt -check
```

#### 3\. **Planificación** 📋[​](#3-planificación- "Enlace directo al 3-planificación-")

```
# Ver qué cambios se aplicarán
terraform plan

# Guardar plan en archivo
terraform plan -out=tfplan

# Plan con variables específicas
terraform plan -var="student_name=Roxs"

# Plan con archivo de variables
terraform plan -var-file="prod.tfvars"

# Plan mostrando solo cambios
terraform plan -compact-warnings
```

#### 4\. **Aplicación** 🚀[​](#4-aplicación- "Enlace directo al 4-aplicación-")

```
# Aplicar cambios (pide confirmación)
terraform apply

# Aplicar sin confirmación
terraform apply -auto-approve

# Aplicar plan guardado
terraform apply tfplan

# Aplicar con variables
terraform apply -var="student_name=TuNombre"
```

#### 5\. **Inspección** 🔍[​](#5-inspección- "Enlace directo al 5-inspección-")

```
# Ver estado actual
terraform show

# Listar recursos en estado
terraform state list

# Ver detalles de un recurso
terraform state show local_file.devops_journey

# Ver outputs
terraform output

# Ver output específico
terraform output generated_files
```

#### 6\. **Destrucción** 🗑️[​](#6-destrucción-️ "Enlace directo al 6-destrucción-️")

```
# Destruir todos los recursos
terraform destroy

# Destruir sin confirmación
terraform destroy -auto-approve

# Destruir recursos específicos
terraform destroy -target=local_file.terraform_config
```

---

## 💡 Conceptos Clave Explicados[​](#-conceptos-clave-explicados "Enlace directo al 💡 Conceptos Clave Explicados")

### 1\. **Providers** 🔌[​](#1-providers- "Enlace directo al 1-providers-")

Los providers son plugins que permiten a Terraform interactuar con APIs:

```
# Provider para AWS
provider "aws" {
  region = "us-east-1"
}

# Provider para Docker
provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Provider para Kubernetes
provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Provider para múltiples clouds
provider "azurerm" {
  features {}
}
```

### 2\. **Resources** 🏗️[​](#2-resources-️ "Enlace directo al 2-resources-️")

Los resources son los componentes de infraestructura:

```
# Sintaxis general
resource "tipo_provider_recurso" "nombre_local" {
  argumento1 = "valor1"
  argumento2 = "valor2"
  
  # Bloque anidado
  configuracion {
    opcion = "valor"
  }
  
  # Meta-argumentos
  depends_on = [otro_recurso.ejemplo]
  count      = 3
  
  # Lifecycle
  lifecycle {
    prevent_destroy = true
  }
}
```

### 3\. **State Management** 💾[​](#3-state-management- "Enlace directo al 3-state-management-")

Terraform mantiene un estado que:

```
# ¿Qué contiene el estado?
✅ Mapeo entre configuración y recursos reales
✅ Metadatos de recursos
✅ Dependencias entre recursos
✅ Configuración de providers

# ¿Por qué es importante?
✅ Detecta cambios (drift detection)
✅ Optimiza operaciones (parallelization)
✅ Permite rollbacks seguros
✅ Habilita colaboración en equipo
```

#### Comandos de Estado[​](#comandos-de-estado "Enlace directo al Comandos de Estado")

```
# Backup manual del estado
cp terraform.tfstate terraform.tfstate.backup

# Importar recurso existente
terraform import aws_instance.example i-1234567890abcdef0

# Remover recurso del estado (sin destruir)
terraform state rm aws_instance.example

# Mover recurso en el estado
terraform state mv aws_instance.old aws_instance.new

# Actualizar estado con infraestructura real
terraform refresh
```

### 4\. **Variables y Tipos** 📝[​](#4-variables-y-tipos- "Enlace directo al 4-variables-y-tipos-")

```
# Tipos básicos
variable "string_example" {
  type    = string
  default = "hello"
}

variable "number_example" {
  type    = number
  default = 42
}

variable "bool_example" {
  type    = bool
  default = true
}

# Tipos complejos
variable "list_example" {
  type    = list(string)
  default = ["item1", "item2", "item3"]
}

variable "map_example" {
  type = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}

variable "object_example" {
  type = object({
    name    = string
    age     = number
    active  = bool
  })
  default = {
    name   = "example"
    age    = 30
    active = true
  }
}
```

### 5\. **Data Sources** 📊[​](#5-data-sources- "Enlace directo al 5-data-sources-")

Para consultar información existente:

```
# Consultar AMI más reciente
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Usar data source en recurso
resource "aws_instance" "example" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = "t3.micro"
}
```

---

## 🧩 Ejercicio Práctico Completo[​](#-ejercicio-práctico-completo "Enlace directo al 🧩 Ejercicio Práctico Completo")

### 🎯 Objetivo[​](#-objetivo "Enlace directo al 🎯 Objetivo")

Crear un proyecto Terraform que genere archivos de configuración personalizados y demuestre conceptos fundamentales.

### 1\. **Preparación del Entorno**[​](#1-preparación-del-entorno "Enlace directo al 1-preparación-del-entorno")

```
# Crear directorio del proyecto
mkdir terraform-dia22-devops
cd terraform-dia22-devops

# Crear estructura de directorios
mkdir -p templates outputs
```

### 2\. **Crear Archivos de Configuración**[​](#2-crear-archivos-de-configuración "Enlace directo al 2-crear-archivos-de-configuración")

#### `terraform.tfvars` (Personaliza con tus datos)[​](#terraformtfvars-personaliza-con-tus-datos "Enlace directo al terraformtfvars-personaliza-con-tus-datos")

```
# Personalización del estudiante
student_name = "TuNombre"       # 👈 Cambia esto
github_user  = "tu-github"      # 👈 Cambia esto  
favorite_language = "Python"    # 👈 Cambia esto

# Configuración del proyecto
project_config = {
  name        = "devops-journey"
  environment = "learning"
  day         = 22
}

# Herramientas DevOps
tools_mastered = [
  "Git",
  "Linux",
  "Docker", 
  "Docker Compose",
  "Terraform"
]

tools_to_learn = [
  "Kubernetes",
  "Helm",
  "ArgoCD",
  "Prometheus",
  "Grafana"
]

# Configuración de archivos
generate_files = {
  readme    = true
  config    = true
  progress  = true
  roadmap   = true
}
```

#### `main.tf` (Configuración Principal)[​](#maintf-configuración-principal "Enlace directo al maintf-configuración-principal")

```
terraform {
  required_version = ">= 1.6"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

# Generar ID único para el proyecto
resource "random_id" "project_id" {
  byte_length = 8
}

# Timestamp de creación
resource "time_static" "creation_time" {}

# Variables locales calculadas
locals {
  project_id = random_id.project_id.hex
  timestamp  = formatdate("YYYY-MM-DD hh:mm:ss", time_static.creation_time.rfc3339)
  
  # Datos del proyecto
  project_data = {
    id          = local.project_id
    name        = var.project_config.name
    student     = var.student_name
    day         = var.project_config.day
    environment = var.project_config.environment
    created_at  = local.timestamp
    github_user = var.github_user
    language    = var.favorite_language
  }
  
  # Progreso calculado
  total_tools     = length(var.tools_mastered) + length(var.tools_to_learn)
  mastered_tools  = length(var.tools_mastered)
  progress_percent = floor((local.mastered_tools / local.total_tools) * 100)
}

# Archivo README personalizado
resource "local_file" "readme" {
  count    = var.generate_files.readme ? 1 : 0
  filename = "README.md"
  content = templatefile("${path.module}/templates/readme.tpl", {
    project = local.project_data
    tools   = {
      mastered = var.tools_mastered
      to_learn = var.tools_to_learn
    }
    progress = local.progress_percent
  })
}

# Configuración del proyecto en JSON
resource "local_file" "project_config" {
  count    = var.generate_files.config ? 1 : 0
  filename = "outputs/project-config.json"
  content = jsonencode({
    project = local.project_data
    terraform = {
      version = "1.6+"
      providers = {
        local  = "~> 2.4"
        random = "~> 3.4"
      }
    }
    learning = {
      tools_mastered    = var.tools_mastered
      tools_to_learn    = var.tools_to_learn
      total_tools       = local.total_tools
      progress_percent  = local.progress_percent
    }
    files_generated = [
      for file_type, enabled in var.generate_files : file_type if enabled
    ]
  })
}

# Reporte de progreso
resource "local_file" "progress_report" {
  count    = var.generate_files.progress ? 1 : 0
  filename = "outputs/progress-report.txt"
  content = templatefile("${path.module}/templates/progress.tpl", {
    student  = var.student_name
    day      = var.project_config.day
    progress = local.progress_percent
    mastered = var.tools_mastered
    to_learn = var.tools_to_learn
    timestamp = local.timestamp
  })
}

# Roadmap personalizado
resource "local_file" "learning_roadmap" {
  count    = var.generate_files.roadmap ? 1 : 0
  filename = "outputs/learning-roadmap.md"
  content = templatefile("${path.module}/templates/roadmap.tpl", {
    student   = var.student_name
    github    = var.github_user
    language  = var.favorite_language
    mastered  = var.tools_mastered
    to_learn  = var.tools_to_learn
    day       = var.project_config.day
  })
}
```

### 3\. **Templates Personalizados**[​](#3-templates-personalizados "Enlace directo al 3-templates-personalizados")

#### `templates/readme.tpl`[​](#templatesreadmetpl "Enlace directo al templatesreadmetpl")

```
# 🚀 ${project.name} - Día ${project.day}

**Estudiante:** ${project.student}  
**GitHub:** [@${project.github_user}](https://github.com/${project.github_user})  
**Progreso:** ${progress}% completado  
**Creado:** ${project.created_at}  

## 📊 Mi Progreso DevOps

### ✅ Herramientas Dominadas (${length(tools.mastered)})
%{ for tool in tools.mastered ~}
- [x] ${tool}
%{ endfor ~}

### 📚 Por Aprender (${length(tools.to_learn)})
%{ for tool in tools.to_learn ~}
- [ ] ${tool}
%{ endfor ~}

## 🎯 Objetivos del Día 22

- [x] Entender Infrastructure as Code
- [x] Instalar Terraform
- [x] Crear primer proyecto
- [x] Manejar variables y outputs
- [x] Usar templates y funciones

## 🏗️ Lo que he construido hoy

Este proyecto fue generado automáticamente usando **Terraform** y demuestra:

- 📝 Variables y tipos de datos
- 🧮 Locals y expresiones
- 📄 Templates con interpolación
- 📊 Outputs estructurados
- 🔢 Funciones built-in

## 🚀 Siguiente Paso

Mañana aprenderé sobre variables avanzadas, funciones y gestión de configuración en Terraform.

---
*Proyecto ID: `${project.id}`*  
*Generado automáticamente por Terraform 🤖*
```

#### `templates/progress.tpl`[​](#templatesprogresstpl "Enlace directo al templatesprogresstpl")

```
===========================================
📊 REPORTE DE PROGRESO - DÍA ${day}
===========================================

👨‍💻 Estudiante: ${student}
📅 Fecha: ${timestamp}
🎯 Progreso General: ${progress}%

📈 ESTADÍSTICAS:
- Herramientas dominadas: ${length(mastered)}
- Por aprender: ${length(to_learn)}
- Total en roadmap: ${length(mastered) + length(to_learn)}

✅ HERRAMIENTAS DOMINADAS:
%{ for tool in mastered ~}
  ✓ ${tool}
%{ endfor ~}

📚 PRÓXIMAS HERRAMIENTAS:
%{ for tool in to_learn ~}
  ◯ ${tool}
%{ endfor ~}

💪 ¡Sigue así! Cada día te acercas más a ser un 
   DevOps Engineer completo.

===========================================
Generado por Terraform - Infrastructure as Code
```

#### `templates/roadmap.tpl`[​](#templatesroadmaptpl "Enlace directo al templatesroadmaptpl")

```
# 🗺️ Mi Roadmap DevOps Personal

**Desarrollado por:** ${student}  
**GitHub:** [${github}](https://github.com/${github})  
**Lenguaje Favorito:** ${language}  
**Día Actual:** ${day}/90  

## 🌟 Mi Journey Hasta Ahora

### 🏆 Skills Dominados
%{ for i, tool in mastered ~}
${i + 1}. **${tool}** ✅
%{ endfor ~}

### 🎯 Próximos Objetivos
%{ for i, tool in to_learn ~}
${i + 1}. **${tool}** 📖
%{ endfor ~}

## 📅 Plan de Acción

### Semana 4: Infrastructure as Code
- [x] **Día 22:** Terraform Basics (HOY)
- [ ] **Día 23:** Variables y Funciones
- [ ] **Día 24:** Módulos y Estructura
- [ ] **Día 25:** Providers y Resources
- [ ] **Día 26:** Estado Remoto
- [ ] **Día 27:** CI/CD con Terraform
- [ ] **Día 28:** Proyecto Final

### 🚀 Proyectos Futuros
- [ ] Infraestructura multi-cloud con Terraform
- [ ] Pipeline CI/CD completo
- [ ] Monitoreo con Prometheus + Grafana
- [ ] Orquestación con Kubernetes

## 💭 Reflexiones

> "La infraestructura como código no es solo una herramienta,
> es una mentalidad que transforma cómo gestionamos la tecnología."

---
*Actualizado automáticamente - Día ${day}*
```

### 4\. **Archivos de Configuración Adicionales**[​](#4-archivos-de-configuración-adicionales "Enlace directo al 4-archivos-de-configuración-adicionales")

#### `variables.tf`[​](#variablestf-1 "Enlace directo al variablestf-1")

```
variable "student_name" {
  description = "Nombre del estudiante DevOps"
  type        = string
  
  validation {
    condition     = length(var.student_name) >= 2
    error_message = "El nombre debe tener al menos 2 caracteres."
  }
}

variable "github_user" {
  description = "Usuario de GitHub"
  type        = string
  default     = "devops-student"
}

variable "favorite_language" {
  description = "Lenguaje de programación favorito"
  type        = string
  default     = "Python"
  
  validation {
    condition = contains([
      "Python", "JavaScript", "Go", "Rust", "Java", "C#", "Ruby"
    ], var.favorite_language)
    error_message = "Debe ser un lenguaje soportado."
  }
}

variable "project_config" {
  description = "Configuración del proyecto"
  type = object({
    name        = string
    environment = string
    day         = number
  })
  
  validation {
    condition     = var.project_config.day >= 1 && var.project_config.day <= 90
    error_message = "El día debe estar entre 1 y 90."
  }
}

variable "tools_mastered" {
  description = "Herramientas DevOps ya dominadas"
  type        = list(string)
  default     = []
}

variable "tools_to_learn" {
  description = "Herramientas DevOps por aprender"
  type        = list(string)
  default     = []
}

variable "generate_files" {
  description = "Qué archivos generar"
  type = object({
    readme   = bool
    config   = bool
    progress = bool
    roadmap  = bool
  })
  default = {
    readme   = true
    config   = true
    progress = true
    roadmap  = true
  }
}
```

#### `outputs.tf`[​](#outputstf-1 "Enlace directo al outputstf-1")

```
output "project_summary" {
  description = "Resumen del proyecto generado"
  value = {
    project_id       = random_id.project_id.hex
    student          = var.student_name
    files_generated  = length([for file, enabled in var.generate_files : file if enabled])
    tools_mastered   = length(var.tools_mastered)
    tools_to_learn   = length(var.tools_to_learn)
    progress_percent = local.progress_percent
    created_at       = local.timestamp
  }
}

output "generated_files" {
  description = "Lista de archivos generados"
  value = {
    readme_md        = var.generate_files.readme ? "README.md" : null
    project_config   = var.generate_files.config ? "outputs/project-config.json" : null
    progress_report  = var.generate_files.progress ? "outputs/progress-report.txt" : null
    learning_roadmap = var.generate_files.roadmap ? "outputs/learning-roadmap.md" : null
  }
}

output "learning_stats" {
  description = "Estadísticas de aprendizaje"
  value = {
    total_tools      = local.total_tools
    mastered_count   = length(var.tools_mastered)
    remaining_count  = length(var.tools_to_learn)
    progress_percent = local.progress_percent
    next_milestone   = local.progress_percent >= 50 ? "¡Más de la mitad!" : "Sigue adelante"
  }
}

output "quick_commands" {
  description = "Comandos útiles para explorar el proyecto"
  value = {
    view_readme     = "cat README.md"
    view_config     = "cat outputs/project-config.json | jq ."
    view_progress   = "cat outputs/progress-report.txt"
    view_roadmap    = "cat outputs/learning-roadmap.md"
    list_files      = "find . -name '*.tf' -o -name '*.json' -o -name '*.md' -o -name '*.txt'"
  }
}
```

### 5\. **Ejecutar el Proyecto**[​](#5-ejecutar-el-proyecto "Enlace directo al 5-ejecutar-el-proyecto")

```
# 1. Inicializar Terraform
terraform init

# 2. Validar configuración
terraform validate

# 3. Formatear código
terraform fmt

# 4. Ver plan de ejecución
terraform plan

# 5. Aplicar configuración
terraform apply

# 6. Explorar archivos generados
ls -la
cat README.md
cat outputs/project-config.json | jq .
cat outputs/progress-report.txt

# 7. Ver outputs
terraform output

# 8. Ver output específico
terraform output learning_stats
```

### 6\. **Experimentar y Personalizar**[​](#6-experimentar-y-personalizar "Enlace directo al 6-experimentar-y-personalizar")

```
# Cambiar variables y re-aplicar
terraform apply -var="student_name=TuNuevoNombre"

# Deshabilitar algunos archivos
terraform apply -var='generate_files={"readme"=true,"config"=false,"progress"=true,"roadmap"=false}'

# Ver el estado actual
terraform show

# Destruir cuando termines
terraform destroy
```

---

## 🔗 Integración con DevOps Pipeline[​](#-integración-con-devops-pipeline "Enlace directo al 🔗 Integración con DevOps Pipeline")

### 🚀 Terraform en CI/CD[​](#-terraform-en-cicd "Enlace directo al 🚀 Terraform en CI/CD")

#### GitHub Actions Ejemplo[​](#github-actions-ejemplo "Enlace directo al GitHub Actions Ejemplo")

```
# .github/workflows/terraform.yml
name: 'Terraform CI/CD'

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  terraform:
    name: 'Terraform'
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout
      uses: actions/checkout@v3
      
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        terraform_version: 1.6.0
        
    - name: Terraform Format
      run: terraform fmt -check
      
    - name: Terraform Init
      run: terraform init
      
    - name: Terraform Validate
      run: terraform validate
      
    - name: Terraform Plan
      run: terraform plan
      
    - name: Terraform Apply
      if: github.ref == 'refs/heads/main'
      run: terraform apply -auto-approve
```

#### GitLab CI Ejemplo[​](#gitlab-ci-ejemplo "Enlace directo al GitLab CI Ejemplo")

```
# .gitlab-ci.yml
stages:
  - validate
  - plan
  - deploy

variables:
  TF_ROOT: ${CI_PROJECT_DIR}
  TF_VERSION: "1.6.0"

before_script:
  - wget -O terraform.zip "https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip"
  - unzip terraform.zip && rm terraform.zip
  - mv terraform /usr/local/bin/
  - cd $TF_ROOT

validate:
  stage: validate
  script:
    - terraform init -backend=false
    - terraform validate
    - terraform fmt -check

plan:
  stage: plan
  script:
    - terraform init
    - terraform plan -out=tfplan
  artifacts:
    paths:
      - $TF_ROOT/tfplan

deploy:
  stage: deploy
  script:
    - terraform init
    - terraform apply tfplan
  only:
    - main
```

### 🐳 Terraform con Docker[​](#-terraform-con-docker "Enlace directo al 🐳 Terraform con Docker")

```
# Dockerfile para Terraform
FROM hashicorp/terraform:1.6

# Instalar herramientas adicionales
RUN apk add --no-cache \
    aws-cli \
    git \
    curl \
    jq

# Copiar configuración
WORKDIR /workspace
COPY . .

# Script de entrada
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
```

### 🔧 Script de Automatización[​](#-script-de-automatización "Enlace directo al 🔧 Script de Automatización")

```
#!/bin/bash
# deploy.sh - Script de despliegue automatizado

set -e

# Variables
ENVIRONMENT=${1:-dev}
ACTION=${2:-plan}

echo "🚀 Terraform Deployment Script"
echo "Environment: $ENVIRONMENT"
echo "Action: $ACTION"

# Validar argumentos
if [[ ! "$ENVIRONMENT" =~ ^(dev|staging|prod)$ ]]; then
    echo "❌ Error: Environment debe ser dev, staging o prod"
    exit 1
fi

if [[ ! "$ACTION" =~ ^(plan|apply|destroy)$ ]]; then
    echo "❌ Error: Action debe ser plan, apply o destroy"
    exit 1
fi

# Configurar backend dinámicamente
export TF_VAR_environment=$ENVIRONMENT

# Ejecutar Terraform
echo "📋 Inicializando Terraform..."
terraform init \
    -backend-config="key=environments/${ENVIRONMENT}/terraform.tfstate"

echo "✅ Validando configuración..."
terraform validate

echo "🔍 Ejecutando $ACTION..."
case $ACTION in
    plan)
        terraform plan -var-file="environments/${ENVIRONMENT}.tfvars"
        ;;
    apply)
        terraform apply -var-file="environments/${ENVIRONMENT}.tfvars" -auto-approve
        ;;
    destroy)
        read -p "⚠️  ¿Estás seguro de destruir $ENVIRONMENT? (yes/no): " confirm
        if [[ $confirm == "yes" ]]; then
            terraform destroy -var-file="environments/${ENVIRONMENT}.tfvars" -auto-approve
        else
            echo "❌ Operación cancelada"
            exit 1
        fi
        ;;
esac

echo "✨ ¡Operación completada!"
```

---

## 🎲 Desafíos Extra (Opcional)[​](#-desafíos-extra-opcional "Enlace directo al 🎲 Desafíos Extra (Opcional)")

### 🏆 Desafío 1: Infrastructure Calculator[​](#-desafío-1-infrastructure-calculator "Enlace directo al 🏆 Desafío 1: Infrastructure Calculator")

Crear un calculador de costos de infraestructura usando Terraform:

```
# infrastructure-calculator/main.tf
variable "instances" {
  type = map(object({
    count = number
    type  = string
    hours = number
  }))
}

locals {
  # Precios por hora (ejemplo)
  pricing = {
    "t3.micro"  = 0.0104
    "t3.small"  = 0.0208
    "t3.medium" = 0.0416
    "t3.large"  = 0.0832
  }
  
  # Calcular costos
  costs = {
    for name, config in var.instances :
    name => config.count * config.hours * local.pricing[config.type]
  }
  
  total_cost = sum(values(local.costs))
}

resource "local_file" "cost_report" {
  filename = "cost-report.json"
  content = jsonencode({
    instances   = var.instances
    costs       = local.costs
    total_cost  = local.total_cost
    currency    = "USD"
    generated_at = timestamp()
  })
}
```

### 🏆 Desafío 2: Multi-Environment Generator[​](#-desafío-2-multi-environment-generator "Enlace directo al 🏆 Desafío 2: Multi-Environment Generator")

Generar configuraciones para múltiples ambientes:

```
# multi-env/variables.tf
variable "environments" {
  type = map(object({
    region          = string
    instance_count  = number
    instance_type   = string
    database_size   = string
    backup_enabled  = bool
  }))
  default = {
    dev = {
      region         = "us-east-1"
      instance_count = 1
      instance_type  = "t3.micro"
      database_size  = "small"
      backup_enabled = false
    }
    staging = {
      region         = "us-west-2"
      instance_count = 2
      instance_type  = "t3.small"
      database_size  = "medium"
      backup_enabled = true
    }
    prod = {
      region         = "eu-west-1"
      instance_count = 3
      instance_type  = "t3.large"
      database_size  = "large"
      backup_enabled = true
    }
  }
}

# Generar archivo por ambiente
resource "local_file" "environment_configs" {
  for_each = var.environments
  
  filename = "environments/${each.key}.tf"
  content = templatefile("${path.module}/templates/environment.tpl", {
    env_name = each.key
    config   = each.value
  })
}
```

### 🏆 Desafío 3: Dynamic Infrastructure[​](#-desafío-3-dynamic-infrastructure "Enlace directo al 🏆 Desafío 3: Dynamic Infrastructure")

Infraestructura que se adapta según parámetros:

```
variable "workload_type" {
  description = "Tipo de carga de trabajo"
  type        = string
  validation {
    condition = contains([
      "web", "api", "database", "cache", "queue"
    ], var.workload_type)
    error_message = "Workload type must be valid."
  }
}

locals {
  # Configuración dinámica según workload
  workload_configs = {
    web = {
      instances    = 3
      type         = "t3.medium"
      load_balancer = true
      auto_scaling  = true
    }
    api = {
      instances    = 2
      type         = "t3.small"
      load_balancer = true
      auto_scaling  = true
    }
    database = {
      instances    = 1
      type         = "r5.large"
      load_balancer = false
      auto_scaling  = false
    }
    cache = {
      instances    = 2
      type         = "r5.medium"
      load_balancer = false
      auto_scaling  = true
    }
    queue = {
      instances    = 1
      type         = "t3.small"
      load_balancer = false
      auto_scaling = true
    }
  }
  
  selected_config = local.workload_configs[var.workload_type]
}

resource "local_file" "infrastructure_plan" {
  filename = "infrastructure-plan-${var.workload_type}.json"
  content = jsonencode({
    workload_type = var.workload_type
    configuration = local.selected_config
    estimated_cost = local.selected_config.instances * (
      local.selected_config.type == "t3.micro"  ? 8.5 :
      local.selected_config.type == "t3.small"  ? 17 :
      local.selected_config.type == "t3.medium" ? 34 :
      local.selected_config.type == "r5.medium" ? 67 :
      local.selected_config.type == "r5.large"  ? 134 : 50
    )
    components = {
      compute      = "EC2 Instances"
      networking   = "VPC + Subnets"
      load_balancer = local.selected_config.load_balancer ? "Application Load Balancer" : null
      auto_scaling = local.selected_config.auto_scaling ? "Auto Scaling Group" : null
    }
  })
}
```

### 🎯 ¿Cómo Resolver los Desafíos?[​](#-cómo-resolver-los-desafíos "Enlace directo al 🎯 ¿Cómo Resolver los Desafíos?")

1.  **Crea directorios separados** para cada desafío
2.  **Experimenta con variables** diferentes
3.  **Observa los outputs** generados
4.  **Modifica los templates** para personalizar
5.  **Combina conceptos** aprendidos hoy

```
# Estructura sugerida
terraform-challenges/
├── challenge-1-calculator/
├── challenge-2-multi-env/
├── challenge-3-dynamic/
└── solutions/  # Tus soluciones
```








