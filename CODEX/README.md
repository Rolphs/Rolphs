# CODEX

Entorno personal de exploración y desarrollo experimental.

Este espacio dentro de `Rolphs` organiza los distintos flujos de trabajo de investigación, prototipado, integración y prueba de ideas emergentes.

---

## Estructura de trabajo

- **concepts/**  
  Notas conceptuales, ideas, hipótesis, modelos mentales y frameworks en construcción.

- **experiments/**
  Prototipos iniciales, pruebas rápidas, código de exploración para validar ideas o construir MVPs.

- **datasets/**  
  Conjuntos de datos de prueba, pequeños corpus o datasets de trabajo experimental.

- **papers/**  
  Artículos, papers, resúmenes y anotaciones sobre literatura relevante.

- **notebooks/**  
  Jupyter notebooks para exploración de datos, modelos y análisis interactivos.

- **tools/**
  Scripts utilitarios, funciones recurrentes, herramientas internas de apoyo.

Todas estas carpetas pueden estar inicialmente vacías y solo contienen un
archivo oculto `.gitkeep` para que Git las registre en el repositorio.

Al ejecutar `./experiments/new_experiment.sh` se crea un nuevo experimento y se
realiza un commit y push automáticamente. El script usa `set -euo pipefail` para
detenerse ante cualquier error y muestra mensajes de ayuda si los comandos de
Git fallan. Ahora admite la opción `--no-push` para omitir el envío manualmente,
y si no existe remoto configurado simplemente avisa y continúa.

### Ejemplo de uso

```bash
./experiments/new_experiment.sh
```

El script realiza los siguientes pasos (si existe un remoto como `origin`,
intentará hacer push al finalizar):

1. **Creación de carpeta**: genera un directorio numerado con un `README.md` y
   `notes.md` iniciales.
2. **Commit automático**: registra la nueva carpeta en Git y crea un commit.
3. **Push**: envía el commit al remoto configurado. Si no hay remoto,
   simplemente se muestra un aviso y el script continúa. También puedes
   desactivar el push con `--no-push`.

---

## Propósito

CODEX funciona como un sistema vivo de trabajo personal, orientado a:

- Explorar ideas nuevas sin compromisos de producción.
- Generar código funcional para validar conceptos.
- Desarrollar modelos de IA, pipelines o integraciones de forma incremental.
- Documentar el pensamiento detrás de cada línea de trabajo.

---
