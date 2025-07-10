# Challenge Day 6

## Objective
Create an Ansible playbook called `deplegar_app.yml` that:
- Installs NGINX and creates a personalized landing page
- Creates a user called `devops` with sudo access
- Configures firewall rules for ports 22, 80, and 443
- Uses a professional structure with `inventories/` and `roles/`

Additionally, integrate this deployment with Vagrant so the virtual machine is configured automatically.