# Día 18: Self-hosted Runner Básico 

## 🏠 Tu propia máquina ejecutando CI/CD[](https://90daysdevops.295devops.com/semana-02/dia8#-tu-propia-m%C3%A1quina-ejecutando-cicd "Enlace directo al 🏠 Tu propia máquina ejecutando CI/CD")


Hoy vas a aprender a configurar un **self-hosted runner**: una máquina propia que ejecuta workflows de GitHub Actions.  
Ideal para pruebas reales, acceso a servicios locales, o proyectos donde querés más control.

___

##  ¿Por qué usar un runner propio?[](https://90daysdevops.295devops.com/semana-02/dia8#-por-qu%C3%A9-usar-un-runner-propio "Enlace directo al 🤔 ¿Por qué usar un runner propio?")

| GitHub-hosted | Self-hosted |
| --- | --- |
| ✅ Fácil y rápido | 🔧 Más configurable |
| ✅ Siempre limpio | 🛠️ Persistencia entre builds |
| ❌ Limitado a 2,000 min/mes | ✅ Sin límite de minutos |
| ❌ No accede a recursos locales | ✅ Accede a tu red, archivos, puertos |

🧠 Lo usás cuando querés:

-   Acceso a bases de datos locales
-   Ejecutar contenedores pesados
-   Saltarte límites de tiempo
-   Automatizar despliegues internos

___

## 🛠️ Paso 1: Preparar tu máquina[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-paso-1-preparar-tu-m%C3%A1quina "Enlace directo al 🛠️ Paso 1: Preparar tu máquina")

```
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl wget git docker.io
sudo usermod -aG docker $USER
newgrp docker
```

📌 Verificá:
```
docker --version
```
___

## 🛡️ Paso 2: Crear el runner en GitHub[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-paso-2-crear-el-runner-en-github "Enlace directo al 🛡️ Paso 2: Crear el runner en GitHub")

1.  Andá a tu repositorio → ⚙️ _Settings_ → _Actions_ → _Runners_
2.  Click en **“New self-hosted runner”**
3.  Elegí Linux y copiá el token y comandos que te da

![](https://90daysdevops.295devops.com/assets/images/1-a7a6cdf185b3817dc8066c55994d67ff.png)

___

## 🔧 Paso 3: Configurar el runner[](https://90daysdevops.295devops.com/semana-02/dia8#-paso-3-configurar-el-runner "Enlace directo al 🔧 Paso 3: Configurar el runner")

```
mkdir actions-runner && cd actions-runner

# Descargar
curl -o actions-runner-linux-x64-2.311.0.tar.gz -L \
  https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz

tar xzf actions-runner-linux-x64-2.311.0.tar.gz

# Configurar (reemplazá los datos)
./config.sh \
  --url https://github.com/TU-USUARIO/TU-REPO \
  --token TU-TOKEN \
  --name mi-runner-local \
  --labels self-hosted,linux,rox \
  --work _work \
  --replace
```

## ![](https://90daysdevops.295devops.com/assets/images/3-d2726e4e400bd4a27a02bd824856b6b3.png)

## 🚀 Paso 4: Ejecutar el runner[](https://90daysdevops.295devops.com/semana-02/dia8#-paso-4-ejecutar-el-runner "Enlace directo al 🚀 Paso 4: Ejecutar el runner")
```
#Modo manual
./run.sh
```


![](https://90daysdevops.295devops.com/assets/images/2-89699f4738fb36a316107fbf72d29b44.png)

___

## ✅ Paso 5: Crear workflow que lo use[](https://90daysdevops.295devops.com/semana-02/dia8#-paso-5-crear-workflow-que-lo-use "Enlace directo al ✅ Paso 5: Crear workflow que lo use")

`.github/workflows/self-hosted-test.yml`

```
name: Test en Self-hosted

on:
  push:
    branches: [main]
  workflow_dispatch:

jobs:
  test-local:
    runs-on: [self-hosted]
    
    steps:
    - name: Clonar código
      uses: actions/checkout@v4

    - name: Info del sistema
      run: |
        echo "🏠 Hostname: $(hostname)"
        echo "🔧 Usuario: $(whoami)"
        echo "🕓 Fecha: $(date)"
```

![](https://90daysdevops.295devops.com/assets/images/4-884f8c362ce4e5d822e77d0c55fac756.png)

## ![](https://90daysdevops.295devops.com/assets/images/5-af95e159824fe9b3ba4de01cb768a318.png)[](https://90daysdevops.295devops.com/semana-02/dia8#-1 "Enlace directo al -1")

## 🐳 Extra: Usar Docker en el runner

`.github/workflows/docker-en-runner.yml`

```
name: Docker en Self-hosted

on:
  push:
    branches: [main]

jobs:
  docker-build:
    runs-on: [self-hosted]

    steps:
    - uses: actions/checkout@v4

    - name: Build Docker
      run: docker build -t mi-app:runner .

    - name: Test Docker
      run: |
        docker run -d --name app-runner -p 5000:5000 mi-app:runner
        sleep 10
        curl -f http://localhost:5000/health
        docker stop app-runner && docker rm app-runner
```

___

## 🧪 Tarea del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-tarea-del-d%C3%ADa "Enlace directo al 🧪 Tarea del Día")

1.  Configurá un runner propio
2.  Creá un workflow que lo use
3.  Ejecutá un test local (Flask o Docker)
4.  Verificá que GitHub use tu runner


___

## 🧠 Revisión rápida[](https://90daysdevops.295devops.com/semana-02/dia8#-revisi%C3%B3n-r%C3%A1pida "Enlace directo al 🧠 Revisión rápida")

| Pregunta | ✔️ / ❌ |
| --- | --- |
| ¿Qué es un runner? |  |
| ¿Qué diferencia hay entre self-hosted y GitHub-hosted? |  |
| ¿Podés ejecutar contenedores desde tu runner? |  |

___

## 🏁 Cierre del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-cierre-del-d%C3%ADa "Enlace directo al 🏁 Cierre del Día")

Hoy tenés **tu propio motor de automatización**, sin depender de los recursos de GitHub. Mañana veremos cómo **hacer deploy con Docker Compose**, ideal para entornos completos.

