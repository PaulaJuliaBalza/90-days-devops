# Día 25 - Módulos en Terraform 

-   [📦 Módulos en Terraform](#-módulos-en-terraform)
-   [🧩 ¿Qué son los Módulos?](#-qué-son-los-módulos)
    -   [Tipos de Módulos](#tipos-de-módulos)
-   [🏗️ Estructura de un Módulo](#️-estructura-de-un-módulo)
-   [🛠️ Creando tu Primer Módulo](#️-creando-tu-primer-módulo)
    -   [Estructura del Proyecto](#estructura-del-proyecto)
    -   [`modules/docker-webapp/variables.tf`](#modulesdocker-webappvariablestf)
    -   [`modules/docker-webapp/main.tf`](#modulesdocker-webappmaintf)
    -   [`modules/docker-webapp/outputs.tf`](#modulesdocker-webappoutputstf)
-   [🔧 Usando el Módulo](#-usando-el-módulo)
    -   [Uso Básico](#uso-básico)
    -   [Uso Avanzado](#uso-avanzado)
-   [📚 Módulos desde el Registry](#-módulos-desde-el-registry)
    -   [Usando Módulos Públicos](#usando-módulos-públicos)
-   [🔄 Versionado de Módulos](#-versionado-de-módulos)
    -   [Usando Versiones Específicas](#usando-versiones-específicas)
    -   [Constraints de Versión](#constraints-de-versión)
-   [🏢 Módulos para Equipos](#-módulos-para-equipos)
    -   [Estructura Organizacional](#estructura-organizacional)
-   [✅ Buenas Prácticas con Módulos](#-buenas-prácticas-con-módulos)
-   [📝 Recursos Adicionales](#-recursos-adicionales)


## 📦 Módulos en Terraform[​](#-módulos-en-terraform "Enlace directo al 📦 Módulos en Terraform")

![](/assets/images/4-fee28a656993cac37fb5252706805ba9.png)

¡Hoy aprenderemos a crear código reutilizable y modular!  
Los **módulos** son la clave para escribir Terraform mantenible, escalable y DRY (Don't Repeat Yourself).

---

## 🧩 ¿Qué son los Módulos?[​](#-qué-son-los-módulos "Enlace directo al 🧩 ¿Qué son los Módulos?")

Los **módulos** en Terraform son:

-   📦 **Contenedores** de múltiples recursos que se usan juntos
-   🔄 **Componentes reutilizables** de infraestructura
-   🏗️ **Abstracciones** que simplifican configuraciones complejas
-   📚 **Bibliotecas** de mejores prácticas

### Tipos de Módulos[​](#tipos-de-módulos "Enlace directo al Tipos de Módulos")

1.  **Root Module**: El directorio principal donde ejecutas Terraform
2.  **Child Modules**: Módulos llamados por otros módulos
3.  **Published Modules**: Módulos compartidos en registros públicos

---

## 🏗️ Estructura de un Módulo[​](#️-estructura-de-un-módulo "Enlace directo al 🏗️ Estructura de un Módulo")

Un módulo típico tiene esta estructura:

```
modules/
└── webapp/
    ├── main.tf          # Recursos principales
    ├── variables.tf     # Variables de entrada
    ├── outputs.tf       # Valores de salida
    ├── versions.tf      # Requisitos de versión
    ├── README.md        # Documentación
    └── examples/        # Ejemplos de uso
        └── basic/
            ├── main.tf
            └── variables.tf
```

---

## 🛠️ Creando tu Primer Módulo[​](#️-creando-tu-primer-módulo "Enlace directo al 🛠️ Creando tu Primer Módulo")

Vamos a crear un módulo para desplegar una aplicación web con Docker:

### Estructura del Proyecto[​](#estructura-del-proyecto "Enlace directo al Estructura del Proyecto")

```
terraform-modules/
├── modules/
│   └── docker-webapp/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
├── examples/
│   ├── simple-webapp/
│   └── full-stack/
└── main.tf
```

### `modules/docker-webapp/variables.tf`[​](#modulesdocker-webappvariablestf "Enlace directo al modulesdocker-webappvariablestf")

```
# ... (contenido igual que antes)
```

### `modules/docker-webapp/main.tf`[​](#modulesdocker-webappmaintf "Enlace directo al modulesdocker-webappmaintf")

```
# ... (contenido igual que antes)
```

### `modules/docker-webapp/outputs.tf`[​](#modulesdocker-webappoutputstf "Enlace directo al modulesdocker-webappoutputstf")

```
# ... (contenido igual que antes)
```

---

## 🔧 Usando el Módulo[​](#-usando-el-módulo "Enlace directo al 🔧 Usando el Módulo")

### Uso Básico[​](#uso-básico "Enlace directo al Uso Básico")

```
# ... (contenido igual que antes)
```

### Uso Avanzado[​](#uso-avanzado "Enlace directo al Uso Avanzado")

```
# ... (contenido igual que antes)
```

---

## 📚 Módulos desde el Registry[​](#-módulos-desde-el-registry "Enlace directo al 📚 Módulos desde el Registry")

Terraform tiene un registro público de módulos:

### Usando Módulos Públicos[​](#usando-módulos-públicos "Enlace directo al Usando Módulos Públicos")

```
# ... (contenido igual que antes)
```

---

## 🔄 Versionado de Módulos[​](#-versionado-de-módulos "Enlace directo al 🔄 Versionado de Módulos")

### Usando Versiones Específicas[​](#usando-versiones-específicas "Enlace directo al Usando Versiones Específicas")

```
# ... (contenido igual que antes)
```

### Constraints de Versión[​](#constraints-de-versión "Enlace directo al Constraints de Versión")

```
# ... (contenido igual que antes)
```

---

## 🏢 Módulos para Equipos[​](#-módulos-para-equipos "Enlace directo al 🏢 Módulos para Equipos")

### Estructura Organizacional[​](#estructura-organizacional "Enlace directo al Estructura Organizacional")

```
terraform-modules/
├── modules/
│   ├── networking/
│   │   ├── vpc/
│   │   ├── security-groups/
│   │   └── load-balancer/
│   ├── compute/
│   │   ├── webapp/
│   │   ├── database/
│   │   └── cache/
│   └── shared/
│       ├── monitoring/
│       └── logging/
├── examples/
│   ├── dev-environment/
│   └── prod-environment/
└── README.md
```

Esta estructura permite a los equipos compartir y reutilizar módulos para diferentes propósitos (red, cómputo, almacenamiento, seguridad, etc.), facilitando la colaboración y el mantenimiento.

---

## ✅ Buenas Prácticas con Módulos[​](#-buenas-prácticas-con-módulos "Enlace directo al ✅ Buenas Prácticas con Módulos")

-   **Documenta** cada módulo con un `README.md` claro.
-   Usa **nombres descriptivos** para variables y outputs.
-   **Versiona** tus módulos y usa tags en Git.
-   Mantén los módulos **pequeños y enfocados** en una sola responsabilidad.
-   Usa **validaciones** en variables para evitar errores comunes.
-   Proporciona **ejemplos** de uso en la carpeta `examples/`.
-   Publica módulos útiles en el [Terraform Registry](https://registry.terraform.io/) si pueden servir a otros.

---

## 📝 Recursos Adicionales[​](#-recursos-adicionales "Enlace directo al 📝 Recursos Adicionales")

-   [Documentación oficial de módulos en Terraform](https://developer.hashicorp.com/terraform/language/modules)
-   [Terraform Registry](https://registry.terraform.io/)
-   [Ejemplo de módulos en GitHub](https://github.com/terraform-aws-modules)

