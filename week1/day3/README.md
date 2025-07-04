# Día 3 - Provisionamiento con Vagrant 

-   [🎯 ¿Por qué usar Vagrant?](#-por-qué-usar-vagrant)
-   [🔧 **Instalación Rápida**](#-instalación-rápida)
    -   [1\. Instalar VirtualBox (Hipervisor)](#1-instalar-virtualbox-hipervisor)
    -   [2\. Instalar Vagrant](#2-instalar-vagrant)
    -   [3\. Verificar instalación](#3-verificar-instalación)
-   [🛠️ **Instalación en Windows**](#️-instalación-en-windows)
    -   [1\. Instalar prerequisitos (elige una opción)](#1-instalar-prerequisitos-elige-una-opción)
    -   [2\. Instalar Vagrant](#2-instalar-vagrant-1)
    -   [3\. Verificar instalación](#3-verificar-instalación-1)
-   [🚀 **Comandos Esenciales**](#-comandos-esenciales)
-   [📦 Vagrant Boxes: Arquitectura y Fuentes Oficiales](#-vagrant-boxes-arquitectura-y-fuentes-oficiales)
-   [🌐 **Página Oficial de Boxes**](#-página-oficial-de-boxes)
-   [🏗️ **Arquitectura Técnica de los Boxes**](#️-arquitectura-técnica-de-los-boxes)
    -   [1\. **Formatos de Boxes**](#1-formatos-de-boxes)
    -   [2\. **Estructura Interna**](#2-estructura-interna)
    -   [3\. **Componentes Clave**](#3-componentes-clave)
-   [🔧 **Tipos de Boxes por Arquitectura**](#-tipos-de-boxes-por-arquitectura)
    -   [1\. **Por Sistema Operativo**](#1-por-sistema-operativo)
    -   [2\. **Por Hipervisor**](#2-por-hipervisor)
    -   [3\. **Boxes Multi-Provider**](#3-boxes-multi-provider)
-   [🚨 **Mejores Prácticas con Boxes**](#-mejores-prácticas-con-boxes)
-   [🌟 **Boxes Recomendados para DevOps**](#-boxes-recomendados-para-devops)
-   [🏗️ **Tu Primer Vagrantfile**](#️-tu-primer-vagrantfile)
    -   [📝 Explicación:](#-explicación)
-   [🚀 **Comandos Clave de Vagrant**](#-comandos-clave-de-vagrant)
    -   [Ejemplo práctico:](#ejemplo-práctico)
-   [🛠️ **Provisionamiento Avanzado con Shell**](#️-provisionamiento-avanzado-con-shell)
    -   [Caso real: Instalar Docker + Kubernetes](#caso-real-instalar-docker--kubernetes)
    -   [💡 Pro Tip:](#-pro-tip)
-   [🔍 **Debugging y Logs**](#-debugging-y-logs)
-   [📂 **Estructura Recomendada de Proyecto**](#-estructura-recomendada-de-proyecto)
-   [📚 **Tarea Opcional del Día 3**](#-tarea-opcional-del-día-3)
-   [🌟 **Beneficios para DevOps**](#-beneficios-para-devops)


# 🚀 Vagrant: Automatización con Shell

![](/assets/images/1-7bcb81b01457258d1681fd707b4f1f60.png)
📌 **¿Por qué Vagrant?** 

Vagrant es tu **"bot mágico"** para:

-   Crear máquinas virtuales (VMs) **en segundos** 🏗️
-   **Automatizar entornos** de desarrollo/producción 🔄
-   Usar Shell/Bash para configuraciones iniciales 🐚

> 💡 **Key Point**: _"Si lo haces más de 2 veces... ¡automatízalo con Vagrant!"_

![](https://miro.medium.com/v2/resize:fit:1358/1*oYnuOWQTgN82TizKobZpfw.png)

---

> ⚙️ ¡Vagrant + VirtualBox o VMWare = laboratorio DevOps portátil!

---

## 🎯 ¿Por qué usar Vagrant?[​](#-por-qué-usar-vagrant "Enlace directo al 🎯 ¿Por qué usar Vagrant?")

✅ Automatizás el entorno desde cero  
✅ Probás sin miedo (podés destruir y volver a levantar en segundos)  
✅ Es ideal para testear scripts, Ansible, Docker o configuraciones  
✅ ¡Funciona igual en todos los sistemas operativos!

---

## 🔧 **Instalación Rápida**[​](#-instalación-rápida "Enlace directo al -instalación-rápida")

### 1\. Instalar VirtualBox (Hipervisor)[​](#1-instalar-virtualbox-hipervisor "Enlace directo al 1. Instalar VirtualBox (Hipervisor)")

```
sudo apt update && sudo apt install virtualbox -y  # Debian/Ubuntubrew 
install --cask virtualbox  # macOS
```

### 2\. Instalar Vagrant[​](#2-instalar-vagrant "Enlace directo al 2. Instalar Vagrant")

```
sudo apt install vagrant -y  # Linuxbrew install vagrant  # macOS
```

### 3\. Verificar instalación[​](#3-verificar-instalación "Enlace directo al 3. Verificar instalación")

```
vagrant --version# Debe mostrar: Vagrant 2.3.x o superior
```

---

## 🚀 **Comandos Esenciales**[​](#-comandos-esenciales "Enlace directo al -comandos-esenciales")

| Comando                       | Descripción                                                  |
|-------------------------------|--------------------------------------------------------------|
| `vagrant up`                  | Inicia la máquina virtual                                    |
| `vagrant ssh`                 | Conectarse via SSH (necesita cliente como Git Bash)         |
| `vagrant halt`                | Apagar la VM                                                 |
| `vagrant destroy`             | Eliminar la VM completamente                                |
| `vagrant reload --provision` | Reiniciar y re-ejecutar provisionamiento                    |


---

## 📦 Vagrant Boxes: Arquitectura y Fuentes Oficiales[​](#-vagrant-boxes-arquitectura-y-fuentes-oficiales "Enlace directo al 📦 Vagrant Boxes: Arquitectura y Fuentes Oficiales")

## 🌐 **Página Oficial de Boxes**[​](#-página-oficial-de-boxes "Enlace directo al -página-oficial-de-boxes")

La fuente principal para boxes preconstruidos es el **Vagrant Cloud**: 🔗 [https://app.vagrantup.com/boxes/search](https://app.vagrantup.com/boxes/search)

🔍 **¿Qué es un Box?**

Un box es un **paquete portable** que contiene:

-   Sistema operativo base (Ubuntu, CentOS, Windows, etc.)
-   Configuración mínima para funcionar con Vagrant
-   Metadatos de versión y proveedor (VirtualBox, Hyper-V, etc.)

![](https://codingpackets.com/img/blog/vagrant-from-the-start-to-the-beginning/architecture.svg)

---

## 🏗️ **Arquitectura Técnica de los Boxes**[​](#️-arquitectura-técnica-de-los-boxes "Enlace directo al ️-arquitectura-técnica-de-los-boxes")

### 1\. **Formatos de Boxes**[​](#1-formatos-de-boxes "Enlace directo al 1-formatos-de-boxes")
| Formato      | Descripción                          | Uso típico             |
|--------------|--------------------------------------|------------------------|
| `.box`       | Paquete comprimido (tar + gzip)      | Distribución pública   |
| OVA/OVF      | Estándar abierto para VMs            | Importación/Exportación |
| VHD/VMDK     | Discos virtuales nativos             | Hyper-V/VMware         |


### 2\. **Estructura Interna**[​](#2-estructura-interna "Enlace directo al 2-estructura-interna")

```
ubuntu-jammy64/
├── Vagrantfile          # Config base
├── metadata.json        # Versión, proveedor
└── virtualbox/          # Directorio específico
    ├── box.ovf          # Descriptor de VM
    ├── *.vmdk           | Discos virtuales
    └── Vagrantfile      | Config extra

```

### 3\. **Componentes Clave**[​](#3-componentes-clave "Enlace directo al 3-componentes-clave")

-   **metadata.json**: Define nombre, versión y proveedor:
    
    ```
        {
        "name": "ubuntu/jammy64",
        "versions": [{
            "version": "20240415.0.0",
            "providers": [{
            "name": "virtualbox",
            "url": "https://example.com/box.virtualbox.box"
            }]
        }]
        }
    ```
    

---

## 🔧 **Tipos de Boxes por Arquitectura**[​](#-tipos-de-boxes-por-arquitectura "Enlace directo al -tipos-de-boxes-por-arquitectura")

### 1\. **Por Sistema Operativo**[​](#1-por-sistema-operativo "Enlace directo al 1-por-sistema-operativo")
| Box                | Arquitectura | Enlace Oficial                                                                 |
|--------------------|--------------|--------------------------------------------------------------------------------|
| `ubuntu/jammy64`   | x86_64       | [Ubuntu](https://app.vagrantup.com/ubuntu/boxes/jammy64)                      |
| `centos/stream8`   | x86_64       | [CentOS](https://app.vagrantup.com/centos/boxes/stream8)                      |
| `generic/alpine38` | ARM64        | [Alpine](https://app.vagrantup.com/generic/boxes/alpine38)                    |


### 2\. **Por Hipervisor**[​](#2-por-hipervisor "Enlace directo al 2-por-hipervisor")

```
config.vm.box = "debian/bullseye64"
config.vm.box_version = "11.20240325"
config.vm.box_url = "https://app.vagrantup.com/debian/boxes/bullseye64"
```

### 3\. **Boxes Multi-Provider**[​](#3-boxes-multi-provider "Enlace directo al 3-boxes-multi-provider")

Ejemplo con soporte para VirtualBox y Parallels:

```
"providers": [
  {
    "name": "virtualbox",
    "url": "https://example.com/box.vbox.box"
  },
  {
    "name": "parallels",
    "url": "https://example.com/box.parallels.box"
  }
]
```

---

## 🚨 **Mejores Prácticas con Boxes**[​](#-mejores-prácticas-con-boxes "Enlace directo al -mejores-prácticas-con-boxes")

1.  **Verificar checksums**:
    
    ```
    vagrant box add --checksum-type sha256 --checksum 1234... ubuntu/jammy64
    ```
    
2.  **Usar versionado semántico**:
    
    ```
    config.vm.box_version = "~> 2024.04"
    ```
    
3.  **Actualizar boxes periódicamente**:
    
    ```
    vagrant box update
    ```
    
4.  **Eliminar boxes antiguos**:
    
    ```
    vagrant box prune
    ```
    

---

## 🌟 **Boxes Recomendados para DevOps**[​](#-boxes-recomendados-para-devops "Enlace directo al -boxes-recomendados-para-devops")

1.  **Generales**:
    
    -   `ubuntu/focal64` (LTS)
    -   `debian/bullseye64`
2.  **Contenedores**:
    
    -   `generic/alpine314` (5MB!)
    -   `rancher/k3os`
3.  **Enterprise**:
    
    -   `centos/stream9`
    -   `oraclelinux/9`

🔗 **Lista completa**: [Vagrant Cloud - Official Boxes](https://app.vagrantup.com/boxes/search?utf8=%E2%9C%93&sort=downloads&q=official)

---

## 🏗️ **Tu Primer Vagrantfile**[​](#️-tu-primer-vagrantfile "Enlace directo al ️-tu-primer-vagrantfile")

Crea un archivo `Vagrantfile` con este contenido:

```
Vagrant.configure("2") do |config|
  # Usa una imagen ligera de Ubuntu 22.04
  config.vm.box = "ubuntu/jammy64"
  
  # Configuración de red (accesible via IP)
  config.vm.network "private_network", ip: "192.168.33.10"
  
  # Provisionamiento con Shell
  config.vm.provision "shell", inline: <<-SHELL
    echo "¡Hola desde el provisionamiento!" > /tmp/hola.txt
    apt update && apt install -y nginx
    systemctl start nginx
  SHELL
end
```

### 📝 Explicación:[​](#-explicación "Enlace directo al 📝 Explicación:")

-   **`config.vm.box`**: Imagen base (Ubuntu en este caso).
-   **`config.vm.network`**: Asigna IP privada.
-   **`config.vm.provision`**: Ejecuta comandos Shell al iniciar.

---

## 🚀 **Comandos Clave de Vagrant**[​](#-comandos-clave-de-vagrant "Enlace directo al -comandos-clave-de-vagrant")

| Comando              | Descripción                          |
|----------------------|--------------------------------------|
| `vagrant init`       | Crea un Vagrantfile básico           |
| `vagrant up`         | Inicia la VM (+ provisionamiento)    |
| `vagrant ssh`        | Conéctate a la VM por SSH            |
| `vagrant halt`       | Apaga la VM                          |
| `vagrant destroy`    | Elimina la VM (¡cuidado!)            |
| `vagrant provision`  | Re-ejecuta el provisionamiento       |


Re-ejecuta el provisionamiento

### Ejemplo práctico:[​](#ejemplo-práctico "Enlace directo al Ejemplo práctico:")

```
vagrant up  # Inicia la VM y ejecuta el Shell provisioner
vagrant ssh  # Accede a la VM
cat /tmp/hola.txt  # Verifica el archivo creado
```

---

## 🛠️ **Provisionamiento Avanzado con Shell**[​](#️-provisionamiento-avanzado-con-shell "Enlace directo al ️-provisionamiento-avanzado-con-shell")

### Caso real: Instalar Docker + Kubernetes[​](#caso-real-instalar-docker--kubernetes "Enlace directo al Caso real: Instalar Docker + Kubernetes")

Modifica tu `Vagrantfile`:

```
config.vm.provision "shell", inline: <<-SHELL
  # Instalar Docker
  apt update
  apt install -y docker.io
  systemctl enable --now docker
  
  # Instalar kubectl
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  
  # Verificar
  docker --version && kubectl version --client
SHELL
```

### 💡 Pro Tip:[​](#-pro-tip "Enlace directo al 💡 Pro Tip:")

Usa **scripts externos** para organizar mejor tu código:

```
config.vm.provision "shell", path: "scripts/instalar_docker.sh"
```

---

## 🔍 **Debugging y Logs**[​](#-debugging-y-logs "Enlace directo al -debugging-y-logs")

-   **Ver output del provisionamiento**:
    
    ```
    vagrant up --provision | tee vagrant.log
    ```
    
-   **Si falla el Shell**:
    
    1.  Conéctate a la VM: `vagrant ssh`
    2.  Revisa logs en `/var/log/cloud-init-output.log`

---

## 📂 **Estructura Recomendada de Proyecto**[​](#-estructura-recomendada-de-proyecto "Enlace directo al -estructura-recomendada-de-proyecto")

```
mi_proyecto/
├── Vagrantfile          # Config principal
├── scripts/            # Scripts de provisionamiento
│   ├── instalar_nginx.sh
│   └── configurar_db.sh
└── README.md           # Documentación
```

---

## 📚 **Tarea Opcional del Día 3**[​](#-tarea-opcional-del-día-3 "Enlace directo al -tarea-opcional-del-día-3")

#### Crea una VM con:[​](#crea-una-vm-con "Enlace directo al Crea una VM con:")

1.  **Nginx** instalado.
2.  Un archivo en `/var/www/html/index.html` con tu nombre. ó puedes vistar esta web con un monton de [template web](https://startbootstrap.com/themes)
3.  Accesible via browser en `http://192.168.33.10`.

```
# Solución (¡inténtalo antes de ver esto!)config.vm.provision "shell", inline: <<-SHELL  apt update && apt install -y nginx  echo "<h1>Hola, soy [TuNombre]</h1>" > /var/www/html/index.htmlSHELL
```

---

## 🌟 **Beneficios para DevOps**[​](#-beneficios-para-devops "Enlace directo al -beneficios-para-devops")

-   **Reproducibilidad**: Mismo entorno en todos lados.
-   **Velocidad**: `vagrant destroy && vagrant up` = Entorno nuevo en 1 minuto.
-   **Integración con CI/CD**: Usa Vagrant en pipelines.


