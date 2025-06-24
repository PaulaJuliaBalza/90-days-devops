# Día 2: Introducción a Linux y a la terminal

## Parte 1: Comandos básicos
```
# alias (atajos para comandos): crear alias para ahorrar tiempo
#  Tip: Se pueden guardar en ~/.bashrc o ~/.zshrc para que sean permanentes.

alias ll='ls -lah --color=auto'  # Lista archivos con detalles  
alias ..='cd ..'                 # Sube un directorio  
alias gs='git status'            # Ver estado de Git  

# whoami (quien soy): muestra el usuario actual

if [ "$(whoami)" != "root" ]; then  
    echo "¡Error! Necesitas ser root."  
    exit 1  
fi  

# ssh (conexión remota segura)

ssh usuario@servidor          # Conexión básica  
ssh -p 2222 usuario@servidor  # Puerto personalizado  
ssh -i ~/.ssh/mi_llave usuario@servidor  # Usar clave privada  
```