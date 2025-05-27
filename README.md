# Assets Challenge – Solución completa

Este repo contiene:

| Carpeta | Descripción |
|---------|-------------|
| **/sql** | Consultas SQL (una por pregunta) y DDL de la solución subcartera |
| **/scripts** | Script Python que genera >500 registros falsos en `cubo` |
| **/assets-ops** | Aplicación Next.js que permite crear meses + semanas |
| **/db** | Carpeta original del desafío |

## 1. Prerrequisitos
* PostgreSQL ≥ 12 ya con las tablas descritas en el enunciado.
* Node ≥ 18 y npm.
* Python ≥ 3.9 y `pip`.

---

## 2. Consultas SQL

```bash
# editar .env o exportar PG vars si es necesario
psql "$DATABASE_URL" -f sql/P1.sql
psql "$DATABASE_URL" -f sql/P2.sql
psql "$DATABASE_URL" -f sql/P3.sql
psql "$DATABASE_URL" -f sql/P4.sql
```

* La query 04 es DDL + migración; 
* revísala antes de lanzarla en producción.

---

## 2. Consultas SQL

```bash
cd scripts
python -m venv venv && source venv/bin/activate  # opcional
pip install -r requirements.txt

# Crear/cargar .env con DATABASE_URL
cp .env.example .env   # si lo incluyes, o exporta la var

python dummies.py   # inserta 500 filas en cubo
```

## 3. Aplicación Next.js

Para conectar con la base de datos, crea un archivo `.env.local` en la raíz de `assets-ops` con:

```env
DATABASE_URL=postgresql://postgres:tu_contraseña@localhost:5432/assets_db # o la URL que uses
```
Luego, instala las dependencias y corre la app:

```bash
cd assets-ops
npm install
npm run dev

# Abre http://localhost:3000 en tu navegador
# (o el puerto que hayas configurado)
```
---

## 🎉 ¡Listo!  
Eso sería todo Nachito😉

---
