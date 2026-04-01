#!/bin/bash
# ─────────────────────────────────────────────────────────────
#  setup.sh — Configuración inicial para nuevos integrantes
#  Uso: bash scripts/setup.sh
# ─────────────────────────────────────────────────────────────

set -e

echo "🚀 Configurando Sistema Escolar..."

# 1. Copiar .env si no existe
if [ ! -f ".env" ]; then
    cp .env.example .env
    echo "✅ .env creado desde .env.example"
fi

# 2. Levantar contenedores
echo "🐳 Levantando contenedores Docker..."
docker compose up -d --build

# 3. Esperar a que MySQL esté listo
echo "⏳ Esperando base de datos..."
sleep 10

# 4. Instalar dependencias de Composer (si no están)
echo "📦 Instalando dependencias PHP..."
docker compose exec app composer install

# 5. Generar APP_KEY si está vacío
echo "🔑 Generando APP_KEY..."
docker compose exec app php artisan key:generate

# 6. Ejecutar migraciones
echo "🗄️  Ejecutando migraciones..."
docker compose exec app php artisan migrate --seed

# 7. Permisos de storage
docker compose exec app chmod -R 775 storage bootstrap/cache

echo ""
echo "✅ ¡Listo! El sistema está corriendo en:"
echo "   🌐 App:        http://localhost:8080"
echo "   🗄️  phpMyAdmin: http://localhost:8081"
echo "   ⚡ Vite HMR:   http://localhost:5173"
echo ""
