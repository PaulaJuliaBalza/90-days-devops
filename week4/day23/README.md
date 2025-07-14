# Día 23 - Variables y Configuración en Terraform 

-   [🔧 Variables y Configuración en Terraform](#-variables-y-configuración-en-terraform)
    -   [🎯 **Lo que lograrás hoy:**](#-lo-que-lograrás-hoy)
    -   [🚀 **¿Por qué es importante?**](#-por-qué-es-importante)
-   [📝 Variables en Terraform - Fundamentos Avanzados](#-variables-en-terraform---fundamentos-avanzados)
    -   [🏗️ **Anatomía de una Variable**](#️-anatomía-de-una-variable)
    -   [🎯 **Variables con Validaciones Inteligentes**](#-variables-con-validaciones-inteligentes)
-   [🏷️ Tipos de Datos Avanzados](#️-tipos-de-datos-avanzados)
    -   [🔤 **Tipos Primitivos**](#-tipos-primitivos)
    -   [📚 **Tipos Complejos - Lista (List)**](#-tipos-complejos---lista-list)
    -   [🗂️ **Tipos Complejos - Mapa (Map)**](#️-tipos-complejos---mapa-map)
    -   [🏗️ **Tipos Complejos - Objeto (Object)**](#️-tipos-complejos---objeto-object)
    -   [📦 **Tipos Complejos - Set**](#-tipos-complejos---set)
    -   [🔄 **Tipos Dinámicos y Tuplas**](#-tipos-dinámicos-y-tuplas)
-   [📊 Usando Variables de Forma Inteligente](#-usando-variables-de-forma-inteligente)
    -   [🎯 **En Recursos - Técnicas Avanzadas**](#-en-recursos---técnicas-avanzadas)
    -   [🔄 **Interpolación Avanzada y Templates**](#-interpolación-avanzada-y-templates)
    -   [🧮 **Uso de Variables en Expresiones**](#-uso-de-variables-en-expresiones)
-   [🏠 Variables Locales (Locals) - El Poder del Cálculo](#-variables-locales-locals---el-poder-del-cálculo)
    -   [🧮 **¿Por qué usar Locals?**](#-por-qué-usar-locals)
    -   [🎯 **Locals Básicos pero Potentes**](#-locals-básicos-pero-potentes)
    -   [🧮 **Locals Avanzados con Lógica Compleja**](#-locals-avanzados-con-lógica-compleja)
    -   [📋 **Ejemplo de Uso de Locals en Recursos**](#-ejemplo-de-uso-de-locals-en-recursos)
-   [🎯 Mejores Prácticas para Variables](#-mejores-prácticas-para-variables)
    -   [📋 **Naming Conventions**](#-naming-conventions)
    -   [🏗️ **Organización de Variables**](#️-organización-de-variables)
    -   [🔒 **Manejo de Variables Sensibles**](#-manejo-de-variables-sensibles)
    -   [🎛️ **Valores Por Defecto Inteligentes**](#️-valores-por-defecto-inteligentes)
-   [🔧 Troubleshooting de Variables](#-troubleshooting-de-variables)
    -   [❗ **Errores Comunes**](#-errores-comunes)
    -   [🛠️ **Comandos de Debugging**](#️-comandos-de-debugging)
    -   [🔍 **Técnicas de Debugging Avanzadas**](#-técnicas-de-debugging-avanzadas)
-   [🎯 Ejercicios Prácticos Avanzados](#-ejercicios-prácticos-avanzados)
    -   [🏆 **Ejercicio 1: Sistema de Configuración Multi-Ambiente**](#-ejercicio-1-sistema-de-configuración-multi-ambiente)
    -   [🏆 **Ejercicio 2: Validador de Configuración Avanzado**](#-ejercicio-2-validador-de-configuración-avanzado)
    -   [🏆 **Ejercicio 3: Generador de Configuración Dinámica**](#-ejercicio-3-generador-de-configuración-dinámica)
-   [✅ ¿Qué Aprendiste Hoy? - Resumen Completo](#-qué-aprendiste-hoy---resumen-completo)
    -   [🎯 **Variables Avanzadas**](#-variables-avanzadas)
    -   [🧮 **Locals Inteligentes**](#-locals-inteligentes)
    -   [⚡ **Funciones Built-in**](#-funciones-built-in)
    -   [🎛️ **Gestión de Variables**](#️-gestión-de-variables)
    -   [🛠️ **Troubleshooting**](#️-troubleshooting)
-   [🚀 Comandos Esenciales del Día](#-comandos-esenciales-del-día)
-   [🎯 Checklist de Dominio](#-checklist-de-dominio)
    -   [Variables](#variables)
    -   [Locals](#locals)
    -   [Funciones](#funciones)
    -   [Gestión](#gestión)
-   [🔮 ¿Qué Sigue Mañana?](#-qué-sigue-mañana)
    -   [🐳 **Provider Docker**](#-provider-docker)
    -   [🎯 **Lo que construiremos:**](#-lo-que-construiremos)
    -   [💡 **Conceptos nuevos:**](#-conceptos-nuevos)
-   [🏆 Desafío Extra (Opcional)](#-desafío-extra-opcional)
-   [📚 Recursos para Profundizar](#-recursos-para-profundizar)
    -   [🔗 **Documentación Oficial**](#-documentación-oficial)
    -   [🛠️ **Herramientas Útiles**](#️-herramientas-útiles)
    -   [📖 **Lecturas Recomendadas**](#-lecturas-recomendadas)




Ayer aprendiste los fundamentos de Terraform. Hoy profundizaremos en hacer tu código **flexible**, **reutilizable** y **mantenible** usando **variables avanzadas**, **locals inteligentes** y **funciones poderosas**.

### 🎯 **Lo que lograrás hoy:**[​](#-lo-que-lograrás-hoy "Enlace directo al -lo-que-lograrás-hoy")

-   🔧 **Dominar variables complejas** con validaciones robustas
-   🧮 **Crear locals inteligentes** que simplifiquen tu código
-   ⚡ **Usar funciones built-in** para transformar datos
-   🎛️ **Gestionar configuraciones** para múltiples entornos
-   🏗️ **Construir infraestructura dinámica** que se adapte automáticamente

### 🚀 **¿Por qué es importante?**[​](#-por-qué-es-importante "Enlace directo al -por-qué-es-importante")

En el mundo real, la infraestructura debe ser:

-   **📈 Escalable**: Crecer según demanda
-   **🔄 Reutilizable**: Un código para múltiples entornos
-   **🛡️ Segura**: Validaciones que previenen errores
-   **👥 Colaborativa**: Fácil de entender para el equipo

---

## 📝 Variables en Terraform - Fundamentos Avanzados[​](#-variables-en-terraform---fundamentos-avanzados "Enlace directo al 📝 Variables en Terraform - Fundamentos Avanzados")

Las variables son el **corazón de la flexibilidad** en Terraform. Te permiten crear código que se adapta a diferentes escenarios sin duplicación.

### 🏗️ **Anatomía de una Variable**[​](#️-anatomía-de-una-variable "Enlace directo al ️-anatomía-de-una-variable")

```
variable "nombre_variable" {
  description = "Descripción clara y útil"        # 📝 Documentación
  type        = string                            # 🏷️ Tipo de dato
  default     = "valor_por_defecto"              # 🔧 Valor opcional
  sensitive   = false                            # 🔒 ¿Es sensitiva?
  nullable    = false                            # ❌ ¿Permite null?
  
  validation {                                   # ✅ Reglas de validación
    condition     = length(var.nombre_variable) > 3
    error_message = "Debe tener más de 3 caracteres."
  }
}
```

### 🎯 **Variables con Validaciones Inteligentes**[​](#-variables-con-validaciones-inteligentes "Enlace directo al -variables-con-validaciones-inteligentes")

#### `variables.tf`[​](#variablestf "Enlace directo al variablestf")

```
# Variable con múltiples validaciones
variable "app_name" {
  description = "Nombre de la aplicación (debe seguir convenciones)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.app_name))
    error_message = "app_name debe empezar con letra, solo contener minúsculas, números y guiones."
  }
  
  validation {
    condition     = length(var.app_name) >= 3 && length(var.app_name) <= 32
    error_message = "app_name debe tener entre 3 y 32 caracteres."
  }
}

# Variable de entorno con validación estricta
variable "environment" {
  description = "Entorno de despliegue (dev/staging/prod)"
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment debe ser exactamente: dev, staging, o prod."
  }
}

# Variable numérica con rangos
variable "instance_count" {
  description = "Número de instancias (1-10)"
  type        = number
  
  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 10
    error_message = "instance_count debe estar entre 1 y 10."
  }
}

# Variable con validación de formato de email
variable "admin_email" {
  description = "Email del administrador"
  type        = string
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.admin_email))
    error_message = "admin_email debe ser un email válido."
  }
}

# Variable con validación de CIDR
variable "vpc_cidr" {
  description = "CIDR block para VPC"
  type        = string
  default     = "10.0.0.0/16"
  
  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0))
    error_message = "vpc_cidr debe ser un bloque CIDR válido."
  }
  
  validation {
    condition     = split("/", var.vpc_cidr)[1] >= 16 && split("/", var.vpc_cidr)[1] <= 24
    error_message = "vpc_cidr debe tener subnet mask entre /16 y /24."
  }
}

# Variable booleana con valor inteligente
variable "enable_monitoring" {
  description = "Habilitar monitoreo (recomendado para prod)"
  type        = bool
  default     = true
}

# Variable sensitive para secrets
variable "database_password" {
  description = "Password de la base de datos"
  type        = string
  sensitive   = true
  
  validation {
    condition     = length(var.database_password) >= 8
    error_message = "Password debe tener al menos 8 caracteres."
  }
}
```

---

## 🏷️ Tipos de Datos Avanzados[​](#️-tipos-de-datos-avanzados "Enlace directo al 🏷️ Tipos de Datos Avanzados")

### 🔤 **Tipos Primitivos**[​](#-tipos-primitivos "Enlace directo al -tipos-primitivos")

```
# String con validación avanzada
variable "region" {
  description = "Región de AWS"
  type        = string
  default     = "us-west-2"
  
  validation {
    condition = can(regex("^(us|eu|ap|sa|ca|me|af)-(north|south|east|west|central)-[1-9]$", var.region))
    error_message = "Debe ser una región válida de AWS."
  }
}

# Number con límites específicos
variable "port" {
  description = "Puerto de la aplicación"
  type        = number
  default     = 8080
  
  validation {
    condition     = var.port >= 1024 && var.port <= 65535
    error_message = "Puerto debe estar entre 1024 y 65535."
  }
}

# Boolean con lógica condicional
variable "enable_ssl" {
  description = "Habilitar SSL (obligatorio en prod)"
  type        = bool
  default     = true
}
```

### 📚 **Tipos Complejos - Lista (List)**[​](#-tipos-complejos---lista-list "Enlace directo al -tipos-complejos---lista-list")

```
# Lista simple
variable "availability_zones" {
  description = "Zonas de disponibilidad"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b", "us-west-2c"]
  
  validation {
    condition     = length(var.availability_zones) >= 2
    error_message = "Debe especificar al menos 2 zonas de disponibilidad."
  }
}

# Lista de números
variable "allowed_ports" {
  description = "Puertos permitidos en el firewall"
  type        = list(number)
  default     = [22, 80, 443, 8080]
}

# Lista con validación de contenido
variable "supported_instance_types" {
  description = "Tipos de instancia soportados"
  type        = list(string)
  default     = ["t3.micro", "t3.small", "t3.medium"]
  
  validation {
    condition = alltrue([
      for instance_type in var.supported_instance_types :
      can(regex("^(t3|t2|m5|c5)\\.(micro|small|medium|large|xlarge)$", instance_type))
    ])
    error_message = "Todos los tipos de instancia deben ser válidos de AWS."
  }
}
```

### 🗂️ **Tipos Complejos - Mapa (Map)**[​](#️-tipos-complejos---mapa-map "Enlace directo al ️-tipos-complejos---mapa-map")

```
# Map simple
variable "tags" {
  description = "Tags comunes para recursos"
  type        = map(string)
  default = {
    Environment = "dev"
    Project     = "devops-challenge"
    Owner       = "roxs"
    Team        = "devops"
  }
}

# Map con validación
variable "environment_configs" {
  description = "Configuraciones específicas por entorno"
  type = map(object({
    instance_type = string
    min_size      = number
    max_size      = number
  }))
  
  default = {
    dev = {
      instance_type = "t3.micro"
      min_size      = 1
      max_size      = 2
    }
    staging = {
      instance_type = "t3.small"
      min_size      = 2
      max_size      = 4
    }
    prod = {
      instance_type = "t3.medium"
      min_size      = 3
      max_size      = 10
    }
  }
  
  validation {
    condition = alltrue([
      for env, config in var.environment_configs :
      config.min_size <= config.max_size
    ])
    error_message = "min_size debe ser menor o igual que max_size para todos los entornos."
  }
}

# Map anidado complejo
variable "network_config" {
  description = "Configuración de red por región"
  type = map(object({
    vpc_cidr = string
    subnets = map(object({
      cidr = string
      type = string
    }))
  }))
  
  default = {
    "us-west-2" = {
      vpc_cidr = "10.0.0.0/16"
      subnets = {
        public_1 = {
          cidr = "10.0.1.0/24"
          type = "public"
        }
        private_1 = {
          cidr = "10.0.2.0/24" 
          type = "private"
        }
      }
    }
  }
}
```

### 🏗️ **Tipos Complejos - Objeto (Object)**[​](#️-tipos-complejos---objeto-object "Enlace directo al ️-tipos-complejos---objeto-object")

```
# Object simple
variable "database_config" {
  description = "Configuración de base de datos"
  type = object({
    name     = string
    port     = number
    username = string
    ssl      = bool
  })
  
  default = {
    name     = "app_db"
    port     = 5432
    username = "admin"
    ssl      = true
  }
}

# Object complejo con validaciones
variable "application_config" {
  description = "Configuración completa de la aplicación"
  type = object({
    name    = string
    version = string
    
    # Configuración de runtime
    runtime = object({
      language = string
      version  = string
      memory   = number
      cpu      = number
    })
    
    # Configuración de base de datos
    database = object({
      engine   = string
      version  = string
      storage  = number
      backups  = bool
    })
    
    # Features opcionales
    features = object({
      monitoring    = bool
      logging       = bool
      caching       = bool
      load_balancer = bool
    })
    
    # Configuración de red
    networking = object({
      vpc_cidr     = string
      subnet_count = number
      enable_nat   = bool
    })
  })
  
  # Validaciones del objeto
  validation {
    condition     = contains(["python", "nodejs", "java", "go"], var.application_config.runtime.language)
    error_message = "Runtime language debe ser uno de: python, nodejs, java, go."
  }
  
  validation {
    condition     = var.application_config.runtime.memory >= 512 && var.application_config.runtime.memory <= 8192
    error_message = "Memory debe estar entre 512MB y 8GB."
  }
  
  validation {
    condition     = contains(["postgres", "mysql", "mongodb"], var.application_config.database.engine)
    error_message = "Database engine debe ser: postgres, mysql, o mongodb."
  }
}

# Object con valores opcionales
variable "monitoring_config" {
  description = "Configuración de monitoreo (opcional)"
  type = object({
    enabled          = bool
    retention_days   = optional(number, 30)
    alert_email      = optional(string, "admin@company.com")
    slack_webhook    = optional(string)
    custom_metrics   = optional(list(string), [])
  })
  
  default = {
    enabled = true
  }
}
```

### 📦 **Tipos Complejos - Set**[​](#-tipos-complejos---set "Enlace directo al -tipos-complejos---set")

```
# Set de strings (sin duplicados)
variable "security_groups" {
  description = "IDs de grupos de seguridad únicos"
  type        = set(string)
  default     = ["sg-123", "sg-456", "sg-789"]
  
  validation {
    condition = alltrue([
      for sg in var.security_groups :
      can(regex("^sg-[a-z0-9]{8,17}$", sg))
    ])
    error_message = "Todos los security groups deben tener formato válido."
  }
}

# Set de objetos
variable "allowed_cidrs" {
  description = "CIDRs permitidos para acceso"
  type = set(object({
    cidr        = string
    description = string
  }))
  
  default = [
    {
      cidr        = "10.0.0.0/8"
      description = "Red interna"
    },
    {
      cidr        = "172.16.0.0/12"
      description = "Red privada"
    }
  ]
}
```

### 🔄 **Tipos Dinámicos y Tuplas**[​](#-tipos-dinámicos-y-tuplas "Enlace directo al -tipos-dinámicos-y-tuplas")

```
# Tipo any para flexibilidad
variable "custom_config" {
  description = "Configuración personalizada flexible"
  type        = any
  default     = {}
}

# Tupla con tipos específicos
variable "server_specs" {
  description = "Especificaciones del servidor [tipo, vcpu, memoria, storage]"
  type        = tuple([string, number, number, number])
  default     = ["t3.medium", 2, 4096, 20]
  
  validation {
    condition = var.server_specs[1] >= 1 && var.server_specs[1] <= 96  # vCPU
    error_message = "vCPU debe estar entre 1 y 96."
  }
  
  validation {
    condition = var.server_specs[2] >= 512 && var.server_specs[2] <= 768000  # Memory MB
    error_message = "Memoria debe estar entre 512MB y 768GB."
  }
}
```

---

## 📊 Usando Variables de Forma Inteligente[​](#-usando-variables-de-forma-inteligente "Enlace directo al 📊 Usando Variables de Forma Inteligente")

### 🎯 **En Recursos - Técnicas Avanzadas**[​](#-en-recursos---técnicas-avanzadas "Enlace directo al -en-recursos---técnicas-avanzadas")

```
# Uso básico de variables
resource "local_file" "basic_config" {
  filename = "${var.app_name}-config.txt"
  content  = templatefile("${path.module}/templates/config.tmpl", {
    app_name    = var.app_name
    environment = var.environment
    port        = var.port
    enabled     = var.enable_monitoring
  })
}

# Uso condicional de variables
resource "local_file" "conditional_config" {
  count = var.environment == "prod" ? 1 : 0
  
  filename = "${var.app_name}-production.conf"
  content = templatefile("${path.module}/templates/prod-config.tmpl", {
    app_name     = var.app_name
    ssl_enabled  = var.environment == "prod" ? true : var.enable_ssl
    replica_count = var.environment == "prod" ? 3 : 1
  })
}

# Uso dinámico con for_each
resource "local_file" "multi_env_configs" {
  for_each = var.environment_configs
  
  filename = "${var.app_name}-${each.key}.json"
  content = jsonencode({
    environment   = each.key
    instance_type = each.value.instance_type
    scaling = {
      min = each.value.min_size
      max = each.value.max_size
    }
    features = {
      monitoring = each.key == "prod" ? true : var.enable_monitoring
      ssl        = each.key == "prod" ? true : false
    }
  })
}
```

### 🔄 **Interpolación Avanzada y Templates**[​](#-interpolación-avanzada-y-templates "Enlace directo al -interpolación-avanzada-y-templates")

```
# Template con lógica condicional compleja
resource "local_file" "advanced_config" {
  filename = "app-${var.environment}.conf"
  content = <<-EOF
    # Configuración generada para ${upper(var.app_name)}
    # Entorno: ${title(var.environment)}
    # Generado: ${timestamp()}
    
    [APPLICATION]
    name = ${var.app_name}
    environment = ${var.environment}
    version = ${lookup(var.application_config, "version", "1.0.0")}
    
    [RUNTIME]
    language = ${var.application_config.runtime.language}
    memory = ${var.application_config.runtime.memory}MB
    cpu = ${var.application_config.runtime.cpu}
    
    [DATABASE]
    engine = ${var.application_config.database.engine}
    host = ${var.environment == "prod" ? "prod-db.internal" : "dev-db.local"}
    port = ${var.database_config.port}
    ssl = ${var.database_config.ssl ? "enabled" : "disabled"}
    backups = ${var.application_config.database.backups ? "enabled" : "disabled"}
    
    [FEATURES]
    %{ if var.application_config.features.monitoring ~}
    monitoring_enabled = true
    monitoring_endpoint = /metrics
    %{ endif ~}
    
    %{ if var.application_config.features.logging ~}
    logging_enabled = true
    log_level = ${var.environment == "prod" ? "info" : "debug"}
    %{ endif ~}
    
    %{ if var.application_config.features.caching ~}
    cache_enabled = true
    cache_ttl = ${var.environment == "prod" ? "3600" : "300"}
    %{ endif ~}
    
    [NETWORKING]
    %{ for zone in var.availability_zones ~}
    availability_zone = ${zone}
    %{ endfor ~}
    
    vpc_cidr = ${var.application_config.networking.vpc_cidr}
    subnet_count = ${var.application_config.networking.subnet_count}
    
    [SECURITY]
    %{ for sg in var.security_groups ~}
    security_group = ${sg}
    %{ endfor ~}
    
    %{ for cidr in var.allowed_cidrs ~}
    # ${cidr.description}
    allowed_cidr = ${cidr.cidr}
    %{ endfor ~}
    
    [PORTS]
    %{ for port in var.allowed_ports ~}
    allowed_port = ${port}
    %{ endfor ~}
  EOF
}

# Generación dinámica de archivos de configuración por componente
resource "local_file" "component_configs" {
  for_each = toset(["frontend", "backend", "database", "cache"])
  
  filename = "components/${each.key}-${var.environment}.yaml"
  content = templatefile("${path.module}/templates/${each.key}.yaml.tpl", {
    component   = each.key
    environment = var.environment
    app_name    = var.app_name
    config      = var.application_config
    
    # Configuración específica por componente
    replicas = {
      frontend = var.environment == "prod" ? 3 : 1
      backend  = var.environment == "prod" ? 2 : 1
      database = 1
      cache    = var.environment == "prod" ? 2 : 1
    }[each.key]
    
    resources = {
      frontend = { cpu = "100m", memory = "128Mi" }
      backend  = { cpu = "200m", memory = "256Mi" }
      database = { cpu = "500m", memory = "1Gi" }
      cache    = { cpu = "100m", memory = "64Mi" }
    }[each.key]
  })
}
```

### 🧮 **Uso de Variables en Expresiones**[​](#-uso-de-variables-en-expresiones "Enlace directo al -uso-de-variables-en-expresiones")

```
# Cálculos dinámicos basados en variables
resource "local_file" "calculated_config" {
  filename = "calculated-resources.json"
  content = jsonencode({
    # Cálculo de recursos totales
    total_cpu_cores = sum([
      for config in values(var.environment_configs) : 
      config.min_size * lookup({
        "t3.micro"  = 1,
        "t3.small"  = 1,
        "t3.medium" = 2,
        "t3.large"  = 2
      }, config.instance_type, 1)
    ])
    
    # Cálculo de memoria total
    total_memory_gb = sum([
      for config in values(var.environment_configs) :
      config.min_size * lookup({
        "t3.micro"  = 1,
        "t3.small"  = 2,
        "t3.medium" = 4,
        "t3.large"  = 8
      }, config.instance_type, 1)
    ])
    
    # Cálculo de costos estimados
    monthly_cost_estimate = sum([
      for env, config in var.environment_configs :
      config.min_size * lookup({
        "t3.micro"  = 8.5,
        "t3.small"  = 17.0,
        "t3.medium" = 34.0,
        "t3.large"  = 67.0
      }, config.instance_type, 25.0)
    ])
    
    # Configuración optimizada por entorno
    optimized_configs = {
      for env, config in var.environment_configs :
      env => merge(config, {
        # Auto-scaling inteligente
        desired_capacity = max(config.min_size, 
          env == "prod" ? 3 : 1
        )
        
        # Features automáticas por entorno
        features_enabled = {
          monitoring = env == "prod" ? true : var.enable_monitoring
          backup     = env == "prod" ? true : false
          encryption = env == "prod" ? true : false
          cdn        = env == "prod" ? true : false
        }
      })
    }
  })
}
```

---

## 🏠 Variables Locales (Locals) - El Poder del Cálculo[​](#-variables-locales-locals---el-poder-del-cálculo "Enlace directo al 🏠 Variables Locales (Locals) - El Poder del Cálculo")

Los **locals** son variables calculadas que transforman y combinan datos. Son el **cerebro** de tu configuración.

### 🧮 **¿Por qué usar Locals?**[​](#-por-qué-usar-locals "Enlace directo al -por-qué-usar-locals")

-   🚀 **Performance**: Se calculan una vez, se usan muchas veces
-   🎯 **Claridad**: Simplifican expresiones complejas
-   🔄 **Reutilización**: Un cálculo, múltiples usos
-   🛡️ **Mantenibilidad**: Centralizan la lógica de negocio

### 🎯 **Locals Básicos pero Potentes**[​](#-locals-básicos-pero-potentes "Enlace directo al -locals-básicos-pero-potentes")

```
locals {
  # 🏷️ Naming conventions automatizadas
  resource_prefix = "${var.app_name}-${var.environment}"
  dns_name        = "${var.app_name}.${var.environment}.company.com"
  
  # 📅 Timestamps inteligentes
  creation_timestamp = timestamp()
  readable_date      = formatdate("YYYY-MM-DD", timestamp())
  unique_suffix      = formatdate("YYYYMMDD-hhmm", timestamp())
  
  # 🏷️ Tags estandarizados
  common_tags = merge(var.tags, {
    Terraform     = "true"
    Environment   = var.environment
    Application   = var.app_name
    CreatedDate   = local.readable_date
    ResourceGroup = local.resource_prefix
  })
  
  # 🔄 Transformaciones de datos
  uppercase_tags = {
    for key, value in local.common_tags : 
    upper(key) => upper(value)
  }
  
  # 📊 Configuraciones por entorno
  env_settings = {
    dev = {
      instance_type    = "t3.micro"
      min_replicas     = 1
      max_replicas     = 2
      enable_logging   = true
      enable_monitoring = false
      backup_retention = 7
    }
    staging = {
      instance_type    = "t3.small"
      min_replicas     = 2
      max_replicas     = 4
      enable_logging   = true
      enable_monitoring = true
      backup_retention = 14
    }
    prod = {
      instance_type    = "t3.medium"
      min_replicas     = 3
      max_replicas     = 10
      enable_logging   = true
      enable_monitoring = true
      backup_retention = 30
    }
  }
  
  # 🎯 Configuración actual automática
  current_env = local.env_settings[var.environment]
}
```

### 🧮 **Locals Avanzados con Lógica Compleja**[​](#-locals-avanzados-con-lógica-compleja "Enlace directo al -locals-avanzados-con-lógica-compleja")

```
locals {
  # 🏗️ Configuración de infraestructura inteligente
  infrastructure_config = {
    # Auto-dimensionamiento basado en entorno
    compute = {
      instance_type = local.current_env.instance_type
      desired_capacity = local.current_env.min_replicas
      
      # Optimización automática de recursos
      cpu_credits = startswith(local.current_env.instance_type, "t3") ? "unlimited" : null
      
      # Configuración de storage por tipo de instancia
      root_volume_size = lookup({
        "t3.micro"  = 8
        "t3.small"  = 10
        "t3.medium" = 15
        "t3.large"  = 20
      }, local.current_env.instance_type, 10)
    }
    
    # Red inteligente basada en número de AZs
    networking = {
      vpc_cidr = "10.${var.environment == "prod" ? 0 : var.environment == "staging" ? 1 : 2}.0.0/16"
      
      # Subnets automáticas
      public_subnets = [
        for i, az in var.availability_zones :
        "10.${var.environment == "prod" ? 0 : var.environment == "staging" ? 1 : 2}.${i + 1}.0/24"
      ]
      
      private_subnets = [
        for i, az in var.availability_zones :
        "10.${var.environment == "prod" ? 0 : var.environment == "staging" ? 1 : 2}.${i + 10}.0/24"
      ]
      
      # NAT Gateways inteligentes
      enable_nat_gateway = var.environment == "prod" ? true : false
      single_nat_gateway = var.environment != "prod" ? true : false
    }
    
    # Base de datos optimizada
    database = merge(var.database_config, {
      # Tamaño automático basado en entorno
      allocated_storage = {
        dev     = 20
        staging = 50
        prod    = 100
      }[var.environment]
      
      # Configuración de backup inteligente
      backup_retention_period = local.current_env.backup_retention
      backup_window          = var.environment == "prod" ? "03:00-04:00" : "02:00-03:00"
      maintenance_window     = var.environment == "prod" ? "sun:04:00-sun:05:00" : "sun:03:00-sun:04:00"
      
      # Multi-AZ solo en producción
      multi_az = var.environment == "prod" ? true : false
      
      # Tipo de instancia optimizado
      instance_class = {
        dev     = "db.t3.micro"
        staging = "db.t3.small" 
        prod    = "db.r5.large"
      }[var.environment]
    })
  }
  
  # 🔐 Configuración de seguridad dinámica
  security_config = {
    # Reglas de firewall inteligentes
    ingress_rules = concat(
      # HTTP/HTTPS básico
      [
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "HTTP access"
        },
        {
          from_port   = 443
          to_port     = 443
          protocol    = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
          description = "HTTPS access"
        }
      ],
      
      # SSH solo para no-producción o con restricciones
      var.environment != "prod" ? [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_blocks = ["10.0.0.0/8"]
          description = "SSH access from internal network"
        }
      ] : [],
      
      # Puertos de aplicación personalizados
      [
        for port in var.allowed_ports : {
          from_port   = port
          to_port     = port
          protocol    = "tcp"
          cidr_blocks = [local.infrastructure_config.networking.vpc_cidr]
          description = "Application port ${port}"
        }
      ],
      
      # Acceso a base de datos solo desde VPC
      [
        {
          from_port   = var.database_config.port
          to_port     = var.database_config.port
          protocol    = "tcp"
          cidr_blocks = [local.infrastructure_config.networking.vpc_cidr]
          description = "Database access from VPC"
        }
      ]
    )
    
    # Encriptación automática por entorno
    encryption_config = {
      ebs_encrypted          = var.environment == "prod" ? true : false
      s3_sse_algorithm      = var.environment == "prod" ? "aws:kms" : "AES256"
      rds_storage_encrypted = var.environment == "prod" ? true : false
    }
  }
  
  # 📊 Cálculos de costos y recursos
  cost_analysis = {
    # Estimación mensual por servicio
    monthly_costs = {
      compute = local.current_env.min_replicas * lookup({
        "t3.micro"  = 8.5
        "t3.small"  = 17.0
        "t3.medium" = 34.0
        "t3.large"  = 67.0
      }, local.current_env.instance_type, 25.0)
      
      database = lookup({
        "db.t3.micro" = 15.0
        "db.t3.small" = 30.0
        "db.r5.large" = 182.0
      }, local.infrastructure_config.database.instance_class, 50.0)
      
      storage = local.infrastructure_config.database.allocated_storage * 0.115
      
      network = var.environment == "prod" ? 45.0 : 15.0
    }
    
    total_monthly_estimate = sum(values(local.cost_analysis.monthly_costs))
    
    # Recursos totales calculados
    total_resources = {
      vcpus = local.current_env.min_replicas * lookup({
        "t3.micro"  = 1
        "t3.small"  = 1
        "t3.medium" = 2
        "t3.large"  = 2
      }, local.current_env.instance_type, 1)
      
      memory_gb = local.current_env.min_replicas * lookup({
        "t3.micro"  = 1
        "t3.small"  = 2
        "t3.medium" = 4
        "t3.large"  = 8
      }, local.current_env.instance_type, 2)
      
      storage_gb = local.current_env.min_replicas * local.infrastructure_config.compute.root_volume_size
    }
  }
  
  # 🎛️ Features dinámicas habilitadas
  enabled_features = {
    monitoring = local.current_env.enable_monitoring || var.enable_monitoring
    logging    = local.current_env.enable_logging
    backup     = var.environment != "dev"
    cdn        = var.environment == "prod"
    waf        = var.environment == "prod"
    
    # Auto-scaling inteligente
    auto_scaling = {
      enabled     = local.current_env.max_replicas > local.current_env.min_replicas
      min_size    = local.current_env.min_replicas
      max_size    = local.current_env.max_replicas
      target_cpu  = var.environment == "prod" ? 70 : 80
    }
  }
}
```

### 📋 **Ejemplo de Uso de Locals en Recursos**[​](#-ejemplo-de-uso-de-locals-en-recursos "Enlace directo al -ejemplo-de-uso-de-locals-en-recursos")

```
# Archivo de configuración de infraestructura completa
resource "local_file" "infrastructure_summary" {
  filename = "${local.resource_prefix}-infrastructure.json"
  content = jsonencode({
    project_info = {
      name         = var.app_name
      environment  = var.environment
      created_at   = local.creation_timestamp
      resource_prefix = local.resource_prefix
    }
    
    infrastructure = local.infrastructure_config
    security       = local.security_config
    cost_analysis  = local.cost_analysis
    features       = local.enabled_features
    components     = local.application_components
  })
}

# Archivo de configuración por componente
resource "local_file" "component_configs" {
  for_each = local.application_components
  
  filename = "components/${each.key}-${var.environment}.yaml"
  content = templatefile("${path.module}/templates/component.yaml.tpl", {
    component_name = each.key
    component_config = each.value
    environment = var.environment
    tags = local.common_tags
    security_group = local.security_groups[each.key]
  })
}

# Terraform workspace summary
resource "local_file" "workspace_summary" {
  filename = "${local.resource_prefix}-summary.txt"
  content = <<-EOF
    🚀 TERRAFORM WORKSPACE SUMMARY
    ================================
    
    📋 PROJECT INFORMATION
    Name: ${var.app_name}
    Environment: ${upper(var.environment)}
    Created: ${local.readable_date}
    Resource Prefix: ${local.resource_prefix}
    
    🏗️ INFRASTRUCTURE
    VPC CIDR: ${local.infrastructure_config.networking.vpc_cidr}
    Instance Type: ${local.infrastructure_config.compute.instance_type}
    Min Replicas: ${local.current_env.min_replicas}
    Max Replicas: ${local.current_env.max_replicas}
    
    💾 DATABASE
    Engine: ${var.database_config.engine}
    Instance Class: ${local.infrastructure_config.database.instance_class}
    Storage: ${local.infrastructure_config.database.allocated_storage}GB
    Multi-AZ: ${local.infrastructure_config.database.multi_az}
    
    🎛️ FEATURES ENABLED
    %{ for feature, enabled in local.enabled_features ~}
    %{ if enabled ~}
    ✅ ${title(feature)}
    %{ endif ~}
    %{ endfor ~}
    
    📊 RESOURCE ALLOCATION
    Total vCPUs: ${local.cost_analysis.total_resources.vcpus}
    Total Memory: ${local.cost_analysis.total_resources.memory_gb}GB
    Total Storage: ${local.cost_analysis.total_resources.storage_gb}GB
    
    💰 COST ESTIMATION (Monthly)
    Compute: $${local.cost_analysis.monthly_costs.compute}
    Database: $${local.cost_analysis.monthly_costs.database}
    Storage: $${local.cost_analysis.monthly_costs.storage}
    Network: $${local.cost_analysis.monthly_costs.network}
    ──────────────────────────────
    TOTAL: $${local.cost_analysis.total_monthly_estimate}
    
    🏷️ COMMON TAGS
    %{ for key, value in local.common_tags ~}
    ${key}: ${value}
    %{ endfor ~}
    
    ──────────────────────────────
    Generated by Terraform 🤖
  EOF
}
```

---

## 🎯 Mejores Prácticas para Variables[​](#-mejores-prácticas-para-variables "Enlace directo al 🎯 Mejores Prácticas para Variables")

### 📋 **Naming Conventions**[​](#-naming-conventions "Enlace directo al -naming-conventions")

```
# ✅ BUENAS PRÁCTICAS
variable "app_name" {              # ✅ snake_case
  description = "Nombre de la aplicación"  # ✅ Descripción clara
  type        = string             # ✅ Tipo explícito
  
  validation {                     # ✅ Validación incluida
    condition     = can(regex("^[a-z][a-z0-9-]*[a-z0-9]$", var.app_name))
    error_message = "app_name debe seguir convenciones de naming."
  }
}

variable "environment" {
  description = "Entorno de despliegue (dev/staging/prod)"  # ✅ Opciones claras
  type        = string
  
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment debe ser: dev, staging, o prod."
  }
}

# ❌ MALAS PRÁCTICAS
variable "AppName" { }             # ❌ PascalCase
variable "app-name" { }            # ❌ kebab-case
variable "APPNAME" { }             # ❌ UPPERCASE
variable "a" { }                   # ❌ Nombre no descriptivo
```

### 🏗️ **Organización de Variables**[​](#️-organización-de-variables "Enlace directo al ️-organización-de-variables")

```
# variables.tf - Organizado por categorías

# ======================
# CONFIGURACIÓN BÁSICA
# ======================
variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
  # ... configuración
}

variable "environment" {
  description = "Entorno de despliegue"
  type        = string
  # ... configuración
}

# ======================
# CONFIGURACIÓN DE RED
# ======================
variable "vpc_cidr" {
  description = "CIDR block para VPC"
  type        = string
  # ... configuración
}

variable "availability_zones" {
  description = "Zonas de disponibilidad"
  type        = list(string)
  # ... configuración
}

# ======================
# CONFIGURACIÓN DE APLICACIÓN
# ======================
variable "application_config" {
  description = "Configuración completa de la aplicación"
  type = object({
    runtime = object({
      language = string
      version  = string
      memory   = number
      cpu      = number
    })
    # ... más configuración
  })
}

# ======================
# CONFIGURACIÓN SENSIBLE
# ======================
variable "database_password" {
  description = "Password de la base de datos"
  type        = string
  sensitive   = true
  # ... configuración
}
```

### 🔒 **Manejo de Variables Sensibles**[​](#-manejo-de-variables-sensibles "Enlace directo al -manejo-de-variables-sensibles")

```
# Variables marcadas como sensitive
variable "api_key" {
  description = "API key para servicios externos"
  type        = string
  sensitive   = true  # ✅ No aparece en logs
}

variable "database_credentials" {
  description = "Credenciales de base de datos"
  type = object({
    username = string
    password = string
  })
  sensitive = true  # ✅ Todo el objeto es sensitive
}

# Uso de variables sensibles
resource "local_file" "app_config" {
  content = templatefile("${path.module}/templates/config.tpl", {
    api_key = var.api_key
    # La variable sensible se puede usar normalmente
  })
  
  lifecycle {
    ignore_changes = [content]  # ✅ Evita cambios accidentales
  }
}
```

### 🎛️ **Valores Por Defecto Inteligentes**[​](#️-valores-por-defecto-inteligentes "Enlace directo al ️-valores-por-defecto-inteligentes")

```
variable "instance_config" {
  description = "Configuración de instancias"
  type = object({
    type  = optional(string, "t3.micro")      # ✅ Valor por defecto
    count = optional(number)                  # ✅ Sin valor por defecto (requerido cuando se usa)
  })
  default = {}  # ✅ Objeto vacío permite usar solo valores por defecto
}

variable "features" {
  description = "Features de la aplicación"
  type = object({
    monitoring = optional(bool, true)         # ✅ Habilitado por defecto
    backup     = optional(bool, false)       # ✅ Deshabilitado por defecto
    ssl        = optional(bool, true)        # ✅ Habilitado por defecto
  })
  default = {}
}

# Uso con coalesce para fallbacks múltiples
locals {
  final_instance_type = coalesce(
    var.instance_config.type,
    var.environment == "prod" ? "t3.medium" : "t3.micro",
    "t3.micro"  # último fallback
  )
}
```

---

## 🔧 Troubleshooting de Variables[​](#-troubleshooting-de-variables "Enlace directo al 🔧 Troubleshooting de Variables")

### ❗ **Errores Comunes**[​](#-errores-comunes "Enlace directo al -errores-comunes")

#### **Error: Variable not defined**[​](#error-variable-not-defined "Enlace directo al error-variable-not-defined")

```
# ❌ Error
│ Error: Reference to undeclared input variable
│ A variable named "app_name" was referenced but not declared.

# ✅ Solución: Declarar en variables.tf
variable "app_name" {
  description = "Nombre de la aplicación"
  type        = string
}
```

#### **Error: Invalid value for variable**[​](#error-invalid-value-for-variable "Enlace directo al error-invalid-value-for-variable")

```
# ❌ Error
│ Error: Invalid value for variable
│ The value "invalid-env" is not valid for variable "environment"

# ✅ Solución: Revisar validaciones
variable "environment" {
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment debe ser: dev, staging, o prod."
  }
}
```

#### **Error: Type constraint error**[​](#error-type-constraint-error "Enlace directo al error-type-constraint-error")

```
# ❌ Error
│ Error: Invalid value for input variable
│ Expected a string, but got number.

# ✅ Solución: Usar conversión de tipos
locals {
  port_string = tostring(var.port)  # Convertir number a string
}
```

### 🛠️ **Comandos de Debugging**[​](#️-comandos-de-debugging "Enlace directo al ️-comandos-de-debugging")

#### **Validar Variables**[​](#validar-variables "Enlace directo al validar-variables")

```
# Validar todas las variables
terraform validate

# Ver valores de variables
terraform console
> var.app_name
> local.common_tags
> var.application_config.runtime.memory

# Ver variables de entorno
env | grep TF_VAR_

# Ver plan con variables específicas
terraform plan -var="app_name=debug-app"
```

#### **Debugging de Expresiones**[​](#debugging-de-expresiones "Enlace directo al debugging-de-expresiones")

```
# En terraform console
> upper(var.app_name)
> length(var.availability_zones)
> keys(var.tags)
> jsonencode(local.common_tags)

# Testing de funciones
> can(regex("^[a-z-]+$", "test-app"))
> try(var.tags.NonExistent, "default")
> formatdate("YYYY-MM-DD", timestamp())
```

#### **Inspección de Estado**[​](#inspección-de-estado "Enlace directo al inspección-de-estado")

```
# Ver variables en outputs
terraform output

# Ver estado completo
terraform show

# Inspeccionar recursos específicos
terraform state show local_file.config
```

### 🔍 **Técnicas de Debugging Avanzadas**[​](#-técnicas-de-debugging-avanzadas "Enlace directo al -técnicas-de-debugging-avanzadas")

#### **Debugging con Outputs**[​](#debugging-con-outputs "Enlace directo al debugging-con-outputs")

```
# Outputs para debugging
output "debug_info" {
  value = {
    variables = {
      app_name    = var.app_name
      environment = var.environment
      zones       = var.availability_zones
    }
    locals = {
      resource_prefix = local.resource_prefix
      common_tags     = local.common_tags
      current_env     = local.current_env
    }
    computed = {
      validation_results = local.validation_results
      all_validations    = local.all_validations_pass
    }
  }
}

# Output para ver transformaciones
output "transformations" {
  value = {
    original_tags = var.tags
    processed_tags = local.common_tags
    uppercase_tags = local.uppercase_tags
  }
}
```

#### **Archivos de Debug**[​](#archivos-de-debug "Enlace directo al archivos-de-debug")

```
# Archivo de debug con toda la información
resource "local_file" "debug_output" {
  filename = "debug-${var.environment}.json"
  content = jsonencode({
    timestamp = timestamp()
    variables = {
      app_name           = var.app_name
      environment        = var.environment
      application_config = var.application_config
    }
    locals = {
      resource_prefix    = local.resource_prefix
      current_env        = local.current_env
      infrastructure     = local.infrastructure_config
      validation_results = local.validation_results
    }
    terraform_info = {
      workspace = terraform.workspace
      version   = "1.6+"
    }
  })
}
```

---

## 🎯 Ejercicios Prácticos Avanzados[​](#-ejercicios-prácticos-avanzados "Enlace directo al 🎯 Ejercicios Prácticos Avanzados")

### 🏆 **Ejercicio 1: Sistema de Configuración Multi-Ambiente**[​](#-ejercicio-1-sistema-de-configuración-multi-ambiente "Enlace directo al -ejercicio-1-sistema-de-configuración-multi-ambiente")

Crear un sistema que genere configuraciones diferentes para dev, staging y prod:

```
# Challenge: Implementar estas variables y locals
variable "environments" {
  type = map(object({
    instance_type     = string
    min_replicas      = number
    max_replicas      = number
    enable_monitoring = bool
    backup_retention  = number
    ssl_required      = bool
  }))
}

locals {
  # Generar configuración automática para cada ambiente
  environment_configs = {
    for env, config in var.environments :
    env => merge(config, {
      # Auto-sizing basado en environment
      storage_size = env == "prod" ? 100 : env == "staging" ? 50 : 20
      
      # Features automáticas
      cdn_enabled = env == "prod"
      waf_enabled = env == "prod"
      
      # Naming convention
      resource_prefix = "${var.app_name}-${env}"
      
      # Costos estimados
      monthly_cost = config.min_replicas * lookup({
        "t3.micro"  = 8.5
        "t3.small"  = 17.0
        "t3.medium" = 34.0
      }, config.instance_type, 25.0)
    })
  }
}
```

### 🏆 **Ejercicio 2: Validador de Configuración Avanzado**[​](#-ejercicio-2-validador-de-configuración-avanzado "Enlace directo al -ejercicio-2-validador-de-configuración-avanzado")

```
# Challenge: Crear validaciones complejas
locals {
  configuration_validation = {
    # Validar que prod tenga configuración robusta
    prod_requirements_met = (
      var.environment == "prod" ? (
        var.application_config.features.monitoring == true &&
        var.application_config.features.backup == true &&
        var.application_config.runtime.memory >= 1024
      ) : true
    )
    
    # Validar coherencia entre variables
    memory_cpu_ratio = (
      var.application_config.runtime.memory / var.application_config.runtime.cpu
    )
    memory_ratio_valid = (
      local.memory_cpu_ratio >= 256 && local.memory_cpu_ratio <= 2048
    )
    
    # Validar nombres únicos
    resource_names_unique = length(distinct([
      var.app_name,
      var.application_config.name
    ])) == 2
  }
  
  all_validations_passed = alltrue(values(local.configuration_validation))
}

# Generar reporte de validación
resource "local_file" "validation_report" {
  filename = "validation-report-${var.environment}.txt"
  content = <<-EOF
    VALIDATION REPORT
    =================
    
    Environment: ${var.environment}
    Timestamp: ${timestamp()}
    
    Validation Results:
    %{ for check, result in local.configuration_validation ~}
    ${result ? "✅" : "❌"} ${check}: ${result}
    %{ endfor ~}
    
    Overall Status: ${local.all_validations_passed ? "✅ PASSED" : "❌ FAILED"}
    
    %{ if !local.all_validations_passed ~}
    Please fix the failing validations before proceeding.
    %{ endif ~}
  EOF
}
```

### 🏆 **Ejercicio 3: Generador de Configuración Dinámica**[​](#-ejercicio-3-generador-de-configuración-dinámica "Enlace directo al -ejercicio-3-generador-de-configuración-dinámica")

```
# Challenge: Generar configuraciones para múltiples servicios
variable "microservices" {
  type = map(object({
    port         = number
    language     = string
    memory_mb    = number
    replicas     = number
    dependencies = list(string)
  }))
}

locals {
  # Generar configuración para cada microservicio
  service_configs = {
    for service_name, config in var.microservices :
    service_name => {
      # Configuración base
      name = service_name
      
      # Configuración de red
      internal_url = "http://${service_name}:${config.port}"
      
      # Configuración de recursos basada en lenguaje
      resources = {
        cpu = config.language == "java" ? "500m" : 
              config.language == "python" ? "200m" : 
              "100m"
        memory = "${config.memory_mb}Mi"
      }
      
      # Health checks específicos por lenguaje
      health_check = {
        path = config.language == "java" ? "/actuator/health" :
               config.language == "nodejs" ? "/health" :
               "/healthz"
        port = config.port
      }
      
      # Variables de entorno automáticas
      environment_vars = merge(
        {
          SERVICE_NAME = service_name
          SERVICE_PORT = tostring(config.port)
          ENVIRONMENT  = var.environment
        },
        # URLs de dependencias
        {
          for dep in config.dependencies :
          "${upper(dep)}_URL" => "http://${dep}:${var.microservices[dep].port}"
        }
      )
    }
  }
}

# Generar archivos de configuración para cada servicio
resource "local_file" "service_configs" {
  for_each = local.service_configs
  
  filename = "services/${each.key}-config.yaml"
  content = templatefile("${path.module}/templates/service.yaml.tpl", {
    service = each.value
    global_config = {
      app_name    = var.app_name
      environment = var.environment
      tags        = local.common_tags
    }
  })
}
```

---

## ✅ ¿Qué Aprendiste Hoy? - Resumen Completo[​](#-qué-aprendiste-hoy---resumen-completo "Enlace directo al ✅ ¿Qué Aprendiste Hoy? - Resumen Completo")

¡Felicitaciones! Has dominado uno de los aspectos más importantes de Terraform. Hoy aprendiste:

### 🎯 **Variables Avanzadas**[​](#-variables-avanzadas "Enlace directo al -variables-avanzadas")

✅ **Tipos de datos complejos** (objects, maps, lists, sets)  
✅ **Validaciones robustas** con regex y condiciones  
✅ **Variables sensibles** para manejo seguro de secrets  
✅ **Valores opcionales** y por defecto inteligentes  
✅ **Organización** y naming conventions

### 🧮 **Locals Inteligentes**[​](#-locals-inteligentes "Enlace directo al -locals-inteligentes")

✅ **Cálculos complejos** y transformaciones de datos  
✅ **Configuración dinámica** basada en entornos  
✅ **For expressions** y manipulación de colecciones  
✅ **Lógica condicional** avanzada  
✅ **Optimización** de recursos y costos

### ⚡ **Funciones Built-in**[​](#-funciones-built-in "Enlace directo al -funciones-built-in")

✅ **+100 funciones** organizadas por categoría  
✅ **String manipulation** y formateo  
✅ **Operaciones de red** y CIDR  
✅ **Matemáticas** y cálculos  
✅ **Validaciones** y manejo de errores

### 🎛️ **Gestión de Variables**[​](#️-gestión-de-variables "Enlace directo al ️-gestión-de-variables")

✅ **Múltiples fuentes** de asignación (precedencia)  
✅ **Archivos por entorno** y organización  
✅ **Variables de entorno** para CI/CD  
✅ **Estrategias avanzadas** con Vault y secrets

### 🛠️ **Troubleshooting**[​](#️-troubleshooting "Enlace directo al ️-troubleshooting")

✅ **Debugging** de variables y expresiones  
✅ **Validación** y testing  
✅ **Mejores prácticas** de organización

---

## 🚀 Comandos Esenciales del Día[​](#-comandos-esenciales-del-día "Enlace directo al 🚀 Comandos Esenciales del Día")

```
# 🔍 VALIDACIÓN Y DEBUGGING
terraform validate                    # Validar sintaxis
terraform console                     # Consola interactiva
terraform plan -var="app_name=test"   # Plan con variables

# 📊 INSPECCIÓN DE VARIABLES
terraform console
> var.app_name                        # Ver variable
> local.common_tags                   # Ver local
> keys(var.tags)                      # Funciones en tiempo real

# 🎛️ GESTIÓN DE ENTORNOS
terraform apply -var-file="dev.tfvars"
terraform workspace select prod
terraform apply -auto-approve

# 🔧 DEBUGGING AVANZADO
export TF_LOG=DEBUG
terraform plan > debug.log
terraform output debug_info
```

---

## 🎯 Checklist de Dominio[​](#-checklist-de-dominio "Enlace directo al 🎯 Checklist de Dominio")

Marca cada elemento cuando lo hayas practicado:

### Variables[​](#variables "Enlace directo al Variables")

-    ✅ Crear variables con validaciones
-    ✅ Usar tipos complejos (object, map)
-    ✅ Implementar variables sensibles
-    ✅ Configurar valores por defecto

### Locals[​](#locals "Enlace directo al Locals")

-    ✅ Crear locals con cálculos
-    ✅ Usar for expressions
-    ✅ Implementar lógica condicional
-    ✅ Configuración por entorno

### Funciones[​](#funciones "Enlace directo al Funciones")

-    ✅ Usar funciones de string
-    ✅ Manipular colecciones
-    ✅ Calcular CIDRs de red
-    ✅ Formatear fechas

### Gestión[​](#gestión "Enlace directo al Gestión")

-    ✅ Crear archivos .tfvars
-    ✅ Usar variables de entorno
-    ✅ Organizar por ambiente
-    ✅ Debugging con console

---

## 🔮 ¿Qué Sigue Mañana?[​](#-qué-sigue-mañana "Enlace directo al 🔮 ¿Qué Sigue Mañana?")

Mañana en el **Día 24** aplicaremos todo lo aprendido con:

### 🐳 **Provider Docker**[​](#-provider-docker "Enlace directo al -provider-docker")

-   Gestión de imágenes Docker con Terraform
-   Creación y configuración de contenedores
-   Redes y volúmenes
-   Orquestación con docker-compose

### 🎯 **Lo que construiremos:**[​](#-lo-que-construiremos "Enlace directo al -lo-que-construiremos")

-   Stack completo de aplicación web
-   Base de datos PostgreSQL
-   Redis para caché
-   Nginx como proxy reverso
-   Monitoreo con Prometheus

### 💡 **Conceptos nuevos:**[​](#-conceptos-nuevos "Enlace directo al -conceptos-nuevos")

-   Provider configuration
-   Resource dependencies
-   Data sources
-   Resource lifecycle

---

## 🏆 Desafío Extra (Opcional)[​](#-desafío-extra-opcional "Enlace directo al 🏆 Desafío Extra (Opcional)")

**Crea un generador de infraestructura completo** que:

1.  📝 **Tome variables** de múltiples ambientes
2.  🧮 **Calcule recursos** automáticamente
3.  💰 **Estime costos** por ambiente
4.  📊 **Genere reportes** en JSON/YAML
5.  ✅ **Valide configuraciones** complejas

```
# Tu objetivo:
terraform apply -var-file="environments/prod.tfvars"
# Debe generar:
# - Configuraciones por servicio
# - Reportes de costos
# - Validaciones de seguridad
# - Archivos de deployment
```

---

## 📚 Recursos para Profundizar[​](#-recursos-para-profundizar "Enlace directo al 📚 Recursos para Profundizar")

### 🔗 **Documentación Oficial**[​](#-documentación-oficial "Enlace directo al -documentación-oficial")

-   [Variables and Outputs](https://developer.hashicorp.com/terraform/language/values)
-   [Functions Reference](https://developer.hashicorp.com/terraform/language/functions)
-   [Expressions](https://developer.hashicorp.com/terraform/language/expressions)

### 🛠️ **Herramientas Útiles**[​](#️-herramientas-útiles "Enlace directo al ️-herramientas-útiles")

-   [TFLint](https://github.com/terraform-linters/tflint) - Linting avanzado
-   [Terraform Console](https://developer.hashicorp.com/terraform/cli/commands/console) - Testing interactivo
-   [Terraform Graph](https://developer.hashicorp.com/terraform/cli/commands/graph) - Visualización

### 📖 **Lecturas Recomendadas**[​](#-lecturas-recomendadas "Enlace directo al -lecturas-recomendadas")

-   [Terraform Best Practices](https://www.terraform-best-practices.com/) - Guía completa
-   [Variable Validation](https://developer.hashicorp.com/terraform/language/values/variables#custom-validation-rules) - Validaciones avanzadas



