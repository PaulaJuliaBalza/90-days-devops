# Día 20: Monitoreo GitHub Actions

## 📈 Monitoreo y Logs para tu App[](https://90daysdevops.295devops.com/semana-02/dia8#-monitoreo-y-logs-para-tu-app "Enlace directo al 📈 Monitoreo y Logs para tu App")


Hoy vas a implementar **health checks**, **logs simples** y una forma de monitorear tu app incluso desde GitHub Actions.

___

## 🩺 ¿Qué es monitorear?[](https://90daysdevops.295devops.com/semana-02/dia8#-qu%C3%A9-es-monitorear "Enlace directo al 🩺 ¿Qué es monitorear?")

Imaginá que tu app es una tienda física:

| Tienda | Aplicación |
| --- | --- |
| ¿Está abierta? 🏪 | ¿Está viva la app? (`/health`) |
| ¿Entra gente? 👥 | ¿Hay tráfico o actividad? |
| ¿Se vende algo? 💰 | ¿Se completan tareas correctamente? |
| ¿Alarma si hay un problema? 🚨 | ¿Hay logs o alertas de errores? |

___

## 🔍 Paso 1: Health Check simple[](https://90daysdevops.295devops.com/semana-02/dia8#-paso-1-health-check-simple "Enlace directo al 🔍 Paso 1: Health Check simple")

`app/health.js` (versión Node.js)

```
function checkHealth() {
  return {
    status: "OK",
    timestamp: new Date(),
    message: "¡Mi aplicación está funcionando! 🎉"
  };
}

module.exports = { checkHealth };
```

Agregalo a tu ruta `/health` en `server.js`.

___

## 📓 Paso 2: Logs simples[](https://90daysdevops.295devops.com/semana-02/dia8#-paso-2-logs-simples "Enlace directo al 📓 Paso 2: Logs simples")

`app/simple-logger.js`

```
class SimpleLogger {
  write(level, message) {
    const time = new Date().toISOString();
    const log = `[${time}] [${level.toUpperCase()}] ${message}`;
    console.log(log);
    require('fs').appendFileSync('app.log', log + '\n');
  }

  info(msg) { this.write('info', msg); }
  error(msg) { this.write('error', msg); }
}

module.exports = new SimpleLogger();
```

Y en `server.js`:

```
const logger = require('./simple-logger');

app.use((req, res, next) => {
  logger.info(`${req.method} ${req.url}`);
  next();
});

app.get('/health', (req, res) => {
  const health = checkHealth();
  logger.info('Health check realizado');
  res.json(health);
});
```

___

## 📦 Paso 3: Logs con Docker[](https://90daysdevops.295devops.com/semana-02/dia8#-paso-3-logs-con-docker "Enlace directo al 📦 Paso 3: Logs con Docker")

En `docker-compose.yml`:

```
services:
  app:
    ...
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

🧪 Comandos útiles:

```
docker compose logs
docker compose logs app
docker compose logs -f
docker compose logs --tail=10
```

___

## 🔧 Paso 4: Scripts de monitoreo[](https://90daysdevops.295devops.com/semana-02/dia8#-paso-4-scripts-de-monitoreo "Enlace directo al 🔧 Paso 4: Scripts de monitoreo")

`scripts/check-app.sh`

```
#!/bin/bash
echo "🔍 Verificando app..."

curl -f http://localhost:3000/ping && echo "✅ Ping OK"
curl -f http://localhost:3000/health && echo "✅ Health OK"
curl -f http://localhost:3000/ && echo "✅ Home OK"
```

___

## ⏱️ Paso 5: GitHub Actions monitoreando[](https://90daysdevops.295devops.com/semana-02/dia8#%EF%B8%8F-paso-5-github-actions-monitoreando "Enlace directo al ⏱️ Paso 5: GitHub Actions monitoreando")

`.github/workflows/monitoreo.yml`

```
name: Monitoreo Simple

on:
  schedule:
    - cron: '0 */2 * * *'  # Cada 2 horas
  workflow_dispatch:

jobs:
  check-app:
    runs-on: ubuntu-latest

    steps:
    - name: Chequear estado
      run: |
        curl -f https://TU-URL.com/health && echo "✅ App OK" || echo "❌ App caída"
```

💡 Tip: Podés agregar envío de alertas a Slack, Discord o email si falla.

___

## ✅ Tarea del Día[](https://90daysdevops.295devops.com/semana-02/dia8#-tarea-del-d%C3%ADa "Enlace directo al ✅ Tarea del Día")

1.  Implementá `/health` en tu app
2.  Agregá logging básico
3.  Usá `docker logs` para inspeccionar
4.  Agregá un workflow de monitoreo
5.  (Opcional) Automatizá alertas


___

## 🧠 Revisión rápida[](https://90daysdevops.295devops.com/semana-02/dia8#-revisi%C3%B3n-r%C3%A1pida "Enlace directo al 🧠 Revisión rápida")

| Pregunta | ✔️ / ❌ |
| --- | --- |
| ¿Qué es un health check? |  |
| ¿Cómo se revisan los logs en Docker? |  |
| ¿Podés hacer monitoreo desde GitHub Actions? |  |




