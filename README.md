# 🎓 Sistema Control Escolar

Proyecto grupal en **Laravel + MySQL + Vite**, entorno unificado con **Docker**.

---

## 📋 Requisitos (solo estos dos)

| Herramienta | Descarga |
|---|---|
| Docker Desktop | https://www.docker.com/products/docker-desktop |
| Git | https://git-scm.com/downloads |

> ⚠️ **No necesitas** PHP, Composer, Node ni MySQL instalados localmente. Docker los provee.

---

## 🚀 Inicio rápido (primera vez)

```bash
# 1. Clonar el repositorio
git clone <URL_DEL_REPO>
cd sistema-escolar

# 2. Ejecutar el script de configuración
bash scripts/setup.sh
```

Eso es todo. El script hace automáticamente:
- Crea tu `.env` local
- Construye y levanta los contenedores
- Instala dependencias PHP (Composer)
- Genera `APP_KEY`
- Ejecuta migraciones y seeders

### URLs disponibles

| Servicio | URL |
|---|---|
| Aplicación Laravel | http://localhost:8080 |
| phpMyAdmin | http://localhost:8081 |
| Vite (HMR) | http://localhost:5173 |

---

## 🌿 Ramas de Git por módulo

```
main          ← producción (no tocar directamente)
└── dev       ← integración de todos los módulos
    ├── modulo/alumnos
    ├── modulo/docentes
    ├── modulo/rh
    ├── modulo/director
    ├── modulo/sad
    ├── modulo/administrativo
    └── modulo/asistente
```

### Flujo de trabajo diario

```bash
# Antes de empezar a trabajar
git checkout modulo/tu-modulo
git pull origin dev          # traer cambios de otros

# Trabajar... hacer cambios...

git add .
git commit -m "feat(alumnos): agregar formulario de registro"
git push origin modulo/tu-modulo

# Cuando el módulo está listo → abrir Pull Request a dev
```

### Convención de commits

```
feat(modulo):    nueva funcionalidad
fix(modulo):     corrección de bug
style(modulo):   cambios de UI/CSS
refactor(modulo): refactorización
db(modulo):      migración o seeder
```

---

## 🐳 Comandos Docker útiles

```bash
# Levantar contenedores
docker compose up -d

# Apagar contenedores
docker compose down

# Ver logs en tiempo real
docker compose logs -f app

# Ejecutar Artisan
docker compose exec app php artisan <comando>

# Ejecutar Composer
docker compose exec app composer <comando>

# Ejecutar npm
docker compose exec node npm <comando>

# Acceder al contenedor PHP
docker compose exec app bash
```

---

## 🗄️ Migraciones

Cada módulo tiene sus propias migraciones. **Nunca editar** una migración ya pusheada a `dev`.  
Si necesitas cambiar la estructura, crea una nueva migración:

```bash
docker compose exec app php artisan make:migration alter_tabla_agregar_campo
```

---

## ⚠️ Reglas del equipo

1. **Nunca** hacer push directo a `main` o `dev`
2. **Siempre** hacer `git pull origin dev` antes de empezar
3. **Nunca** subir el archivo `.env` al repositorio
4. **Siempre** que agregues una dependencia con Composer o npm, avisar al equipo para que corran `composer install` / `npm install`
5. Los conflictos en `composer.lock` se resuelven corriendo `composer install` después del merge

---

## 📁 Estructura del proyecto

```
sistema-escolar/
├── docker-compose.yml
├── .env.example          ← plantilla (sí se sube al repo)
├── .gitignore
├── scripts/
│   └── setup.sh          ← script de inicio rápido
├── docker/
│   ├── php/Dockerfile
│   └── nginx/default.conf
└── app/                  ← código Laravel
    ├── app/
    │   ├── Http/Controllers/
    │   │   ├── AlumnosController.php
    │   │   ├── DocentesController.php
    │   │   └── ...
    │   └── Models/
    ├── database/migrations/
    ├── resources/views/
    └── routes/web.php
```
