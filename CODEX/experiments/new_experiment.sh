#!/bin/bash
set -euo pipefail

# Procesar opciones
NO_PUSH=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    --no-push)
      NO_PUSH=true
      shift
      ;;
    *)
      echo "Uso: $0 [--no-push]" >&2
      exit 1
      ;;
  esac
done

# Ir al directorio actual del script
cd "$(dirname "$0")"

# Buscar el último número de experimento
last_num=$(find . -maxdepth 1 -type d -name 'exp[0-9]*' | sort | tail -n 1 | grep -oE '[0-9]+' | head -n 1 || true)
if [ -z "$last_num" ]; then
  next_num=1
else
  next_num=$((10#$last_num + 1))
fi

# Formatear número a 3 dígitos
exp_num=$(printf "%03d" "$next_num")

# Pedir nombre del experimento
read -rp "Nombre del experimento: " exp_name

# Limpiar nombre (espacios -> guiones bajos)
clean_name=$(echo "$exp_name" | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g')

# Crear carpeta
dir="exp${exp_num}_${clean_name}"
mkdir "$dir"
cd "$dir"

# Crear README.md
cat << EOF2 > README.md
# Experimento ${exp_num} — ${exp_name^}

Descripción inicial del experimento.

---

## Estado

🟡 En preparación.

---

## Objetivo

(TODO: describir el objetivo aquí)

---

## Notas

Las notas detalladas están en \`notes.md\`.

EOF2

# Crear notes.md vacío
touch notes.md

echo "Experimento creado en: $dir"

# Volver al directorio de experimentos y registrar el nuevo commit
cd ..
git add "$dir"
if ! git commit -m "Nuevo experimento inicializado: $dir"; then
  echo "Error: Falló el commit en Git." >&2
  exit 1
fi

if [ "$NO_PUSH" = false ]; then
  if git remote > /dev/null 2>&1; then
    if ! git push; then
      echo "Error: Falló el push. Verifique la configuración del remoto." >&2
      exit 1
    fi
  else
    echo "Aviso: No hay remoto configurado. No se hizo push." >&2
  fi
fi
