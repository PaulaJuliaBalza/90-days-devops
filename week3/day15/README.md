# Día 15: Introducción a CI/CD 
 
Hoy comenzamos con la **automatización del flujo de trabajo con CI/CD** usando **GitHub Actions**.

### En modo DevOps:[](https://90daysdevops.295devops.com/semana-02/dia8#en-modo-devops "Enlace directo al En modo DevOps:")

-   **CI (Continuous Integration)** = Verifica tu código al instante
-   **CD (Continuous Deployment)** = Lo publica automáticamente si todo está bien
-   **Pipeline** = Secuencia de pasos automáticos
___

## 🛠️ ¿Qué es GitHub Actions?[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-qu%C3%A9-es-github-actions "Enlace directo al 🛠️ ¿Qué es GitHub Actions?")

**GitHub Actions** es tu asistente personal dentro de GitHub que te permite:

-   🔄 Ejecutar tareas cuando hacés un `push` o `pull request`
-   🧪 Probar automáticamente tu app
-   📦 Construirla, empaquetarla o desplegarla
-   🛎️ Avisarte si algo falla

### Conceptos Clave:[](https://90daysdevops.295devops.com/semana-02/dia8#conceptos-clave "Enlace directo al Conceptos Clave:")

| Concepto | ¿Qué significa? |
| --- | --- |
| **Workflow** | Un flujo de tareas automatizadas |
| **Job** | Un grupo de pasos que se ejecutan juntos |
| **Step** | Una acción específica (comando o tarea) |
| **Runner** | Máquina que ejecuta los jobs |

___

## ✨ ¡Tu primer workflow de CI/CD![](https://90daysdevops.295devops.com/semana-02/dia8#-tu-primer-workflow-de-cicd "Enlace directo al ✨ ¡Tu primer workflow de CI/CD!")

### Paso 1: Crear tu proyecto[](https://90daysdevops.295devops.com/semana-02/dia8#paso-1-crear-tu-proyecto "Enlace directo al Paso 1: Crear tu proyecto")

```
mkdir mi-primer-ci-cd
cd mi-primer-ci-cd
git init
echo "# Mi Primer CI/CD" > README.md
git add .
git commit -m "Inicio de proyecto"
```

### Paso 2: Crear la estructura[](https://90daysdevops.295devops.com/semana-02/dia8#paso-2-crear-la-estructura "Enlace directo al Paso 2: Crear la estructura")

```
mkdir -p .github/workflows
```

### Paso 3: Crear el workflow `.github/workflows/hola-mundo.yml`[](https://90daysdevops.295devops.com/semana-02/dia8#paso-3-crear-el-workflow-githubworkflowshola-mundoyml "Enlace directo al paso-3-crear-el-workflow-githubworkflowshola-mundoyml")

```
name: Mi Primer CI/CD

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:

jobs:
  saludar:
    runs-on: ubuntu-latest
    steps:
    - name: 📥 Descargar código
      uses: actions/checkout@v4

    - name: 👋 ¡Hola mundo DevOps!
      run: |
        echo "¡Hola DevOps con Roxs! 🚀"
        date
        uname -a

    - name: 🧪 Test Matemático
      run: |
        if [ $((2+2)) -eq 4 ]; then
          echo "✅ Todo OK"
        else
          echo "❌ Algo falló"
          exit 1
        fi
```

### Paso 4: Subir tu repositorio[](https://90daysdevops.295devops.com/semana-02/dia8#paso-4-subir-tu-repositorio "Enlace directo al Paso 4: Subir tu repositorio")

```
git remote add origin https://github.com/TU-USUARIO/mi-primer-ci-cd.git
git branch -M main
git push -u origin main
```

📌 **En GitHub → pestaña “Actions” vas a ver tu workflow ejecutándose automáticamente.**

___

## 🎯 Ejercicios prácticos[](https://90daysdevops.295devops.com/semana-02/dia8#-ejercicios-pr%C3%A1cticos "Enlace directo al 🎯 Ejercicios prácticos")

### Ejercicio 1: Workflow con variables[](https://90daysdevops.295devops.com/semana-02/dia8#ejercicio-1-workflow-con-variables "Enlace directo al Ejercicio 1: Workflow con variables")

`.github/workflows/variables.yml`

```
name: Variables DevOps

on: [push, workflow_dispatch]

env:
  PROYECTO: "Mi App DevOps"
  AMBIENTE: "Desarrollo"

jobs:
  mostrar:
    runs-on: ubuntu-latest
    env:
      RESPONSABLE: "Estudiante DevOps"
    steps:
    - name: Mostrar info
      run: |
        echo "Proyecto: $PROYECTO"
        echo "Ambiente: $AMBIENTE"
        echo "Responsable: $RESPONSABLE"
```

### Ejercicio 2: Workflow condicional[](https://90daysdevops.295devops.com/semana-02/dia8#ejercicio-2-workflow-condicional "Enlace directo al Ejercicio 2: Workflow condicional")

`.github/workflows/condicional.yml`

```
name: Rama Detectada

on:
  push:
    branches: [main, develop, feature/*]
  workflow_dispatch:

jobs:
  detectar:
    runs-on: ubuntu-latest
    steps:
    - name: Detectar rama
      run: |
        echo "Rama actual: ${{ github.ref_name }}"
```

___

## 🧠 Revisión rápida[](https://90daysdevops.295devops.com/semana-02/dia8#-revisi%C3%B3n-r%C3%A1pida "Enlace directo al 🧠 Revisión rápida")

| Concepto | ¿Entendiste? |
| --- | --- |
| ¿Qué es CI/CD? | ✅ / ❌ |
| ¿Qué hace un workflow? | ✅ / ❌ |
| ¿Cómo se ejecuta una acción? | ✅ / ❌ |

___

## 📝 Tarea del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-tarea-del-d%C3%ADa "Enlace directo al 📝 Tarea del Día")

✅ Crear tu primer workflow básico 

✅ Crear uno con variables 

✅ Crear uno condicional según la rama 


