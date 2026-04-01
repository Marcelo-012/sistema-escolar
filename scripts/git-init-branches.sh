#!/bin/bash
# ─────────────────────────────────────────────────────────────
#  git-init-branches.sh
#  Ejecutar UNA SOLA VEZ por el líder del proyecto
#  Crea la estructura de ramas en el repositorio remoto
# ─────────────────────────────────────────────────────────────

set -e

MODULOS=(
  "modulo/alumnos"
  "modulo/docentes"
  "modulo/rh"
  "modulo/director"
  "modulo/sad"
  "modulo/administrativo"
  "modulo/asistente"
  "modulo/dep"
  "modulo/da"
)

echo "📌 Creando rama dev..."
git checkout -b dev 2>/dev/null || git checkout dev
git push -u origin dev

echo "🌿 Creando ramas por módulo..."
for modulo in "${MODULOS[@]}"; do
  git checkout -b "$modulo" dev
  git push -u origin "$modulo"
  echo "  ✅ $modulo"
done

git checkout dev
echo ""
echo "✅ Ramas creadas. Comparte el repositorio con tu equipo."
