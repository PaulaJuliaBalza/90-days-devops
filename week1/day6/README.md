

## ⚙️ Introducción a Ansible[](https://90daysdevops.295devops.com/semana-01/dia6#%EF%B8%8F-introducci%C3%B3n-a-ansible "Enlace directo al ⚙️ Introducción a Ansible")


Ansible es una herramienta de automatización **sin agentes** que usa SSH para gestionar servidores. Hoy aprenderás:

-   ✅ Filosofía de Infraestructura como Código (IaC)
-   ✅ Arquitectura de Ansible (Control Node vs Managed Nodes)
-   ✅ Playbooks en YAML
-   ✅ Módulos esenciales

___

## 🧠 **Conceptos Clave**[](https://90daysdevops.295devops.com/semana-01/dia6#-conceptos-clave "Enlace directo al -conceptos-clave")

### 1\. ¿Por qué Ansible?[](https://90daysdevops.295devops.com/semana-01/dia6#1-por-qu%C3%A9-ansible "Enlace directo al 1. ¿Por qué Ansible?")

-   **Agente-less**: No requiere software adicional en los nodos gestionados
-   **Idempotencia**: Ejecuta solo cambios necesarios (no acciones redundantes)
-   **YAML**: Lenguaje humano-readable para playbooks

### 2\. Componentes Principales[](https://90daysdevops.295devops.com/semana-01/dia6#2-componentes-principales "Enlace directo al 2. Componentes Principales")

| Componente | Función |
| --- | --- |
| **Inventario** | Lista de hosts gestionados (`/etc/ansible/hosts`) |
| **Playbooks** | "Recetas" de automatización (archivos YAML) |
| **Módulos** | Unidades de acción (ej: `apt`, `copy`, `service`) |
| **Roles** | Plantillas reusables para organizar playbooks complejos |

___

## 🛠️ **Instalación Básica**[](https://90daysdevops.295devops.com/semana-01/dia6#%EF%B8%8F-instalaci%C3%B3n-b%C3%A1sica "Enlace directo al ️-instalación-básica")

### En el Nodo de Control (Ubuntu):[](https://90daysdevops.295devops.com/semana-01/dia6#en-el-nodo-de-control-ubuntu "Enlace directo al En el Nodo de Control (Ubuntu):")

```
sudo apt update
sudo apt install ansible -y
ansible --version  # Verificar instalación
```

### Configuración Inicial:[](https://90daysdevops.295devops.com/semana-01/dia6#configuraci%C3%B3n-inicial "Enlace directo al Configuración Inicial:")

1.  Editar el inventario:

```
sudo nano /etc/ansible/hosts
```

2.  Añadir tus nodos:

```
[webservers]
192.168.1.10 ansible_user=admin
192.168.1.11 ansible_user=admin

[databases]
db01.example.com
```

___

## 🔄 **Primeros Comandos**[](https://90daysdevops.295devops.com/semana-01/dia6#-primeros-comandos "Enlace directo al -primeros-comandos")

### Test de Conexión:[](https://90daysdevops.295devops.com/semana-01/dia6#test-de-conexi%C3%B3n "Enlace directo al Test de Conexión:")

```
ansible all -m ping -u admin
```

_Salida esperada:_

```
192.168.1.10 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

### Comandos Ad-Hoc:[](https://90daysdevops.295devops.com/semana-01/dia6#comandos-ad-hoc "Enlace directo al Comandos Ad-Hoc:")
Es una forma rápida de ejecutar una sola tarea en uno o varios nodos remotos sin necesidad de escribir un playbook completo. stos comandos son útiles para realizar operaciones simples y puntuales, como verificar el estado de un servicio, instalar un paquete o reiniciar un servidor.
```
# Instalar Nginx en webservers
ansible webservers -m apt -a "name=nginx state=present" -b --become-user=root

# Reiniciar servicios
ansible all -m service -a "name=nginx state=restarted"
```

___

## 📜 **Tu Primer Playbook**[](https://90daysdevops.295devops.com/semana-01/dia6#-tu-primer-playbook "Enlace directo al -tu-primer-playbook")

Crea `primer-playbook.yml`:

```
---
- name: Configuración básica de servidor
  hosts: webservers
  become: yes
  
  tasks:
    - name: Instalar paquetes esenciales
      apt:
        name: ["git", "tree", "htop"]
        state: present
        update_cache: yes

    - name: Crear usuario deploy
      user:
        name: deploy
        groups: sudo
        append: yes
        password: "{{ 'miPassword123' | password_hash('sha512') }}"

    - name: Habilitar firewall
      ufw:
        rule: allow
        port: "22,80,443"
        proto: tcp
```

### Ejecución:[](https://90daysdevops.295devops.com/semana-01/dia6#ejecuci%C3%B3n "Enlace directo al Ejecución:")

```
ansible-playbook primer-playbook.yml
```

___

## 🧩 **Módulos Esenciales**[](https://90daysdevops.295devops.com/semana-01/dia6#-m%C3%B3dulos-esenciales "Enlace directo al -módulos-esenciales")

| Módulo | Uso Típico | Ejemplo |
| --- | --- | --- |
| `copy` | Copiar archivos | `src: files/config.conf dest: /etc/` |
| `template` | Plantillas Jinja2 | `src: templates/nginx.j2 dest: /etc/nginx/nginx.conf` |
| `lineinfile` | Editar líneas específicas | `path: /etc/ssh/sshd_config line: "PermitRootLogin no"` |
| `docker_container` | Gestionar contenedores | `name: mi-app image: nginx:latest ports: "8080:80"` |

___

## 🏗️ **Estructura Profesional**[](https://90daysdevops.295devops.com/semana-01/dia6#%EF%B8%8F-estructura-profesional "Enlace directo al ️-estructura-profesional")

Para proyectos reales:

```
mi-proyecto-ansible/
├── inventories/
│   ├── production/
│   └── staging/
├── roles/
│   ├── nginx/
│   └── mysql/
├── playbooks/
│   ├── deploy-web.yml
│   └── setup-db.yml
└── ansible.cfg
```

___

## 🚨 **Solución de Problemas**[](https://90daysdevops.295devops.com/semana-01/dia6#-soluci%C3%B3n-de-problemas "Enlace directo al -solución-de-problemas")

### Debugging:[](https://90daysdevops.295devops.com/semana-01/dia6#debugging "Enlace directo al Debugging:")

```
ansible-playbook playbook.yml -vvv  # Modo verboso
```

### Check Mode (Dry Run):[](https://90daysdevops.295devops.com/semana-01/dia6#check-mode-dry-run "Enlace directo al Check Mode (Dry Run):")

```
ansible-playbook playbook.yml --check
```

___

## 📌 **Tarea Práctica**[](https://90daysdevops.295devops.com/semana-01/dia6#-tarea-pr%C3%A1ctica "Enlace directo al -tarea-práctica")

1.  Automatiza la instalación de:
    -   Un servidor Nginx con página personalizada
    -   Usuario con acceso SSH
    -   Reglas de firewall básicas

```
# Ejemplo de solución parcial
- name: Desplegar landing page
  hosts: webservers
  tasks:
    - name: Copiar HTML
      copy:
        src: files/index.html
        dest: /var/www/html/
```

___

## 🔗 **Recursos Adicionales**[](https://90daysdevops.295devops.com/semana-01/dia6#-recursos-adicionales "Enlace directo al -recursos-adicionales")

-   [Documentación Oficial](https://docs.ansible.com/)
-   [Galaxy - Roles prehechos](https://galaxy.ansible.com/)

> 💡 **Tip**: Usa `ansible-doc <module>` para ver ayuda de cualquier módulo!

___

## 🚀 Desplegando StartBootstrap Freelancer con Vagrant y Ansible[](https://90daysdevops.295devops.com/semana-01/dia6#-desplegando-startbootstrap-freelancer-con-vagrant-y-ansible "Enlace directo al 🚀 Desplegando StartBootstrap Freelancer con Vagrant y Ansible")

En este ejemplo crearemos un entorno reproducible que:

1.  **Levanta una máquina virtual** con Vagrant
2.  **Configura automáticamente** Nginx usando Ansible
3.  **Despliega el template** Freelancer de StartBootstrap

___

## 📦 Prerrequisitos[](https://90daysdevops.295devops.com/semana-01/dia6#-prerrequisitos "Enlace directo al 📦 Prerrequisitos")

```
# Instalar en tu máquina local:
vagrant --version || brew install vagrant  # macOS
ansible --version || pip install ansible
virtualbox --version || brew install virtualbox
```

___

## 1\. Estructura del Proyecto[](https://90daysdevops.295devops.com/semana-01/dia6#1-estructura-del-proyecto "Enlace directo al 1. Estructura del Proyecto")

```
freelancer-deploy/
├── Vagrantfile          # Configuración de la VM
├── playbook.yml         # Automatización Ansible
├── files/
│   └── nginx.conf       # Config personalizada
```

___

## 2\. Configuración de Vagrant (`Vagrantfile`)[](https://90daysdevops.295devops.com/semana-01/dia6#2-configuraci%C3%B3n-de-vagrant-vagrantfile "Enlace directo al 2-configuración-de-vagrant-vagrantfile")

```
Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-24.04"
  config.vm.network "private_network", ip: "192.168.33.10"
  
  # Provisionamiento con Ansible
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.verbose = "v"
  end
end
```

___

## 3\. Playbook de Ansible (`playbook.yml`)[](https://90daysdevops.295devops.com/semana-01/dia6#3-playbook-de-ansible-playbookyml "Enlace directo al 3-playbook-de-ansible-playbookyml")

```
---
- name: Despliegue Fullstack Freelancer
  hosts: all
  become: yes

  vars:
    repo_url: "https://github.com/startbootstrap/startbootstrap-freelancer/archive/gh-pages.zip"
    web_root: "/var/www/freelancer"

  tasks:
    - name: Instalar dependencias
      apt:
        name: ["nginx", "unzip", "wget"]
        state: present
        update_cache: yes

    - name: Crear directorio web
      file:
        path: "{{ web_root }}"
        state: directory
        mode: '0755'

    - name: Descargar template
      get_url:
        url: "{{ repo_url }}"
        dest: "/tmp/freelancer.zip"
        mode: '0644'

    - name: Descomprimir template
      unarchive:
        src: "/tmp/freelancer.zip"
        dest: "/tmp/"
        remote_src: yes

    - name: Mover contenido del subdirectorio
      shell: |
        cd /tmp/startbootstrap-freelancer-gh-pages
        cp -r * {{ web_root }}/
        chown -R www-data:www-data {{ web_root }}

    - name: Limpiar archivos temporales
      file:
        path: "{{ item }}"
        state: absent
      loop:
        - "/tmp/freelancer.zip"
        - "/tmp/startbootstrap-freelancer-gh-pages"

    - name: Configurar Nginx
      template:
        src: files/nginx.conf
        dest: /etc/nginx/sites-available/freelancer
      notify: Restart Nginx

    - name: Habilitar sitio
      file:
        src: /etc/nginx/sites-available/freelancer
        dest: /etc/nginx/sites-enabled/freelancer
        state: link

    - name: Eliminar default site
      file:
        path: /etc/nginx/sites-enabled/default
        state: absent

  handlers:
    - name: Restart Nginx
      service:
        name: nginx
        state: restarted
```

___

## 4\. Configuración de Nginx (`files/nginx.conf`)[](https://90daysdevops.295devops.com/semana-01/dia6#4-configuraci%C3%B3n-de-nginx-filesnginxconf "Enlace directo al 4-configuración-de-nginx-filesnginxconf")

```
server {
    listen 80;
    server_name _;
    root /var/www/freelancer;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
```

___

## 🚀 Ejecución[](https://90daysdevops.295devops.com/semana-01/dia6#-ejecuci%C3%B3n "Enlace directo al 🚀 Ejecución")

```
# Iniciar la VM y ejecutar el playbook automáticamente
vagrant up

# Acceder vía SSH para verificar
vagrant ssh
curl localhost

# O desde tu navegador local:
open http://192.168.33.10
```

### Resultado Esperado:[](https://90daysdevops.295devops.com/semana-01/dia6#resultado-esperado "Enlace directo al Resultado Esperado:")

![Freelancer Template](https://90daysdevops.295devops.com/assets/images/2-4a52e189fbf039040b4383055bf4d482.png)

___

## 🛠️ Comandos Útiles para Debugging[](https://90daysdevops.295devops.com/semana-01/dia6#%EF%B8%8F-comandos-%C3%BAtiles-para-debugging "Enlace directo al 🛠️ Comandos Útiles para Debugging")

```
# Re-provisionar sin recrear la VM
vagrant provision

# Ver logs de Nginx
vagrant ssh -c "sudo tail -f /var/log/nginx/error.log"

# Ver contenido descargado
vagrant ssh -c "ls -la /var/www/freelancer"
```

___

## 💡 Mejoras Opcionales[](https://90daysdevops.295devops.com/semana-01/dia6#-mejoras-opcionales "Enlace directo al 💡 Mejoras Opcionales")

1.  **Variables Dinámicas**: Mover `repo_url` a un archivo `vars.yml`
2.  **Templates Jinja2**: Personalizar el HTML antes de desplegar
3.  **HTTPS**: Añadir certificado SSL con Let's Encrypt
4.  **Multi-VM**: Crear un cluster con load balancer

```
# Ejemplo de variable en grupo
- name: Set web_root based on environment
  set_fact:
    web_root: "/var/www/{{ env }}/freelancer"
  when: env is defined
```

___

## 🔌 Uso Avanzado: CLI de Ansible para Aprovisionamiento

___

Además de Vagrant, puedes ejecutar playbooks de Ansible **directamente contra cualquier servidor** (físico, virtual, cloud o contenedor) usando la CLI. Aquí cómo hacerlo:

___

## 🖥️ Método 1: Usando ansible-playbook directamente[](https://90daysdevops.295devops.com/semana-01/dia6#%EF%B8%8F-m%C3%A9todo-1-usando-ansible-playbook-directamente "Enlace directo al 🖥️ Método 1: Usando ansible-playbook directamente")

### Requisitos previos:[](https://90daysdevops.295devops.com/semana-01/dia6#requisitos-previos "Enlace directo al Requisitos previos:")

1.  **Acceso SSH** al servidor destino
2.  **Python instalado** en el nodo gestionado
3.  **Inventario configurado** o dirección IP explícita

```
# Ejecutar playbook en un servidor remoto (sin Vagrant)
ansible-playbook -i 192.168.1.100, -u ubuntu --private-key ~/.ssh/id_rsa playbook.yml
```

### Parámetros clave:[](https://90daysdevops.295devops.com/semana-01/dia6#par%C3%A1metros-clave "Enlace directo al Parámetros clave:")

| Flag | Descripción | Ejemplo |
| --- | --- | --- |
| `-i` | Inventario o IP | `-i mi-inventario.ini` |
| `-u` | Usuario SSH | `-u ec2-user` |
| `--private-key` | Ruta a clave privada | `--key-file ~/.ssh/aws.pem` |
| `-e` | Variables extra | `-e "env=prod"` |
| `-l` | Limitar a hosts específicos | `-l webservers` |

___

## 📋 Ejemplo Completo CLI[](https://90daysdevops.295devops.com/semana-01/dia6#-ejemplo-completo-cli "Enlace directo al 📋 Ejemplo Completo CLI")

### 1\. Crear inventario dinámico (`hosts.ini`)[](https://90daysdevops.295devops.com/semana-01/dia6#1-crear-inventario-din%C3%A1mico-hostsini "Enlace directo al 1-crear-inventario-dinámico-hostsini")

```
[webservers]
web1 ansible_host=192.168.1.100 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa

[databases]
db1 ansible_host=192.168.1.101 ansible_user=admin
```

### 2\. Ejecutar con inventario[](https://90daysdevops.295devops.com/semana-01/dia6#2-ejecutar-con-inventario "Enlace directo al 2. Ejecutar con inventario")

```
ansible-playbook -i hosts.ini playbook.yml
```

### 3\. Sobreescribir variables[](https://90daysdevops.295devops.com/semana-01/dia6#3-sobreescribir-variables "Enlace directo al 3. Sobreescribir variables")

```
ansible-playbook -i hosts.ini playbook.yml -e "web_root=/var/www/custom"
```

___

## 🔄 Comparativa: Vagrant vs CLI pura[](https://90daysdevops.295devops.com/semana-01/dia6#-comparativa-vagrant-vs-cli-pura "Enlace directo al 🔄 Comparativa: Vagrant vs CLI pura")

| Característica | Vagrant | CLI Ansible |
| --- | --- | --- |
| **Entorno** | Máquinas virtuales locales | Cualquier servidor SSH |
| **Uso típico** | Desarrollo/Testing | Producción |
| **Configuración** | `Vagrantfile` | Inventario Ansible |
| **Ventaja principal** | Entorno reproducible | Flexibilidad en conexión |

___

## 🛠️ Comandos Esenciales para Debugging[](https://90daysdevops.295devops.com/semana-01/dia6#%EF%B8%8F-comandos-esenciales-para-debugging "Enlace directo al 🛠️ Comandos Esenciales para Debugging")

```
# Ver hosts disponibles en inventario
ansible-inventory -i hosts.ini --list

# Probar conexión SSH
ansible all -i hosts.ini -m ping

# Ejecutar comando ad-hoc
ansible webservers -i hosts.ini -a "free -h"
```

___

### 🚀 Desafío Ansible - Día 6[](https://90daysdevops.295devops.com/semana-01/dia6#-desaf%C3%ADo-ansible---d%C3%ADa-6 "Enlace directo al 🚀 Desafío Ansible - Día 6")

Este reto forma parte del programa **90 Días de DevOps con Roxs** y te permitirá aplicar lo aprendido sobre Ansible automatizando la configuración de un servidor desde cero.

## 🎯 Objetivo[](https://90daysdevops.295devops.com/semana-01/dia6#-objetivo "Enlace directo al 🎯 Objetivo")

Crear un playbook Ansible llamado `desplegar_app.yml` que:

-   📦 Instale **Nginx** y cree una **landing page personalizada**
-   👤 Cree un usuario **devops** con acceso sudo
-   🔐 Configure reglas de firewall para puertos **22**, **80** y **443**
-   📂 Utilice una **estructura profesional** con `inventories/` y `roles/`

Además, deberás integrar este despliegue con **Vagrant** para que la máquina virtual se configure automáticamente.

___

## 📁 Estructura del Proyecto[](https://90daysdevops.295devops.com/semana-01/dia6#-estructura-del-proyecto "Enlace directo al 📁 Estructura del Proyecto")

```

desafio\_ansible\_dia6/
├── Vagrantfile
├── playbook.yml
├── inventories/
│   └── vagrant
│       └── hosts.ini
├── roles/
│   ├── nginx/
│   │   └── tasks/main.yml
│   ├── devops/
│   │   └── tasks/main.yml
│   └── firewall/
│       └── tasks/main.yml
└── README.md
```

___

## ⚙️ Instrucciones[](https://90daysdevops.295devops.com/semana-01/dia6#%EF%B8%8F-instrucciones "Enlace directo al ⚙️ Instrucciones")

### 1\. Instalación de dependencias[](https://90daysdevops.295devops.com/semana-01/dia6#1-instalaci%C3%B3n-de-dependencias "Enlace directo al 1. Instalación de dependencias")

Asegurate de tener instalados:

```
vagrant --version
ansible --version
virtualbox --version
```

Si te falta alguno, podés instalarlo vía Homebrew (macOS) o apt (Linux).

___

### 2\. Ejecutar la VM[](https://90daysdevops.295devops.com/semana-01/dia6#2-ejecutar-la-vm "Enlace directo al 2. Ejecutar la VM")

Esto levantará la VM y ejecutará automáticamente el playbook `playbook.yml`.
```
vagrant up
```
___

### 3\. Verificar[](https://90daysdevops.295devops.com/semana-01/dia6#3-verificar "Enlace directo al 3. Verificar")

Una vez finalizado:

```
vagrant ssh
curl localhost
```

Deberías ver tu landing page servida por Nginx desde la máquina virtual.

___

## 🧠 Tips[](https://90daysdevops.295devops.com/semana-01/dia6#-tips "Enlace directo al 🧠 Tips")

-   Podés personalizar la landing en `roles/nginx/files/index.html`
-   Para hacer debugging, usá:

```
ansible-playbook playbook.yml -vvv
```

-   Para volver a ejecutar el provisionamiento sin destruir la VM:
```
vagrant provision
```
___

## 🎁 Bonus[](https://90daysdevops.295devops.com/semana-01/dia6#-bonus "Enlace directo al 🎁 Bonus")

-   Añadí más roles como `docker`, `nodejs`, o `python`
-   Usá variables con `vars/` o `group_vars/`
-   Documentá tu código con comentarios y buenas prácticas

___


## 🔗 Recursos[](https://90daysdevops.295devops.com/semana-01/dia6#-recursos "Enlace directo al 🔗 Recursos")

-   [Documentación Oficial de Ansible](https://docs.ansible.com/)
-   [StartBootstrap Templates](https://startbootstrap.com/themes)
-   [Ansible Galaxy](https://galaxy.ansible.com/)