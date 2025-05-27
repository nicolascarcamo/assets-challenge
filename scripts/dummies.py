#!/usr/bin/env python

"""
Uso:
    python dummies.py    # lee DATABASE_URL del entorno o .env // MODIFICAR en -CONFIG- mas abajo
Genera 500 filas dummy en la tabla cubo.
"""
import os, random, string
from faker import Faker
import psycopg2
from psycopg2.extras import execute_values

# ───────────────────────── CONFIG ─────────────────────────
DSN = os.getenv(
    "DATABASE_URL",
    "postgres://postgres:123@localhost:5432/assets_db"  # Hardcodeado no mas
)
BATCH_SIZE = 500                         # filas a insertar
fake = Faker("es_CL")
random.seed(42)
# ───────────────────────── HELPERS ─────────────────────────
def gen_rut():
    """Devuelve (rut, dv) con módulo-11 (formato entero + dígito)"""
    body = random.randint(6_000_000, 25_000_000)       # rango razonable
    s = 0
    factor = 2
    for digit in reversed(str(body)):
        s += int(digit) * factor
        factor = 2 if factor == 7 else factor + 1
    res = 11 - (s % 11)
    dv = "0" if res == 11 else "K" if res == 10 else str(res)
    return body, dv

def rand_code(prefix="COD", length=6):
    return prefix + "".join(random.choices(string.ascii_uppercase + string.digits, k=length))
# ───────────────────────── MAIN ───────────────────────────
with psycopg2.connect(DSN) as conn, conn.cursor() as cur:
    # 1) Catálogos existentes
    cur.execute("""
        SELECT ca.codigo, cl.nombre
        FROM carteras ca
        JOIN clientes cl ON cl.id = ca.id_cliente
    """)
    carteras = cur.fetchall()  # [(codigo_cartera, nombre_cliente), …]

    cur.execute("SELECT nombre FROM gestores")
    gestores = [g[0] for g in cur.fetchall()]

    cur.execute("SELECT codigo FROM meses")
    meses = [m[0] for m in cur.fetchall()]

    if not (carteras and gestores and meses):
        raise RuntimeError("Faltan datos en carteras, gestores o meses para generar cubo.")

    registros = []
    for _ in range(BATCH_SIZE):
        cartera_codigo, cliente_nombre = random.choice(carteras)
        gestor_nombre = random.choice(gestores)
        envio_codigo  = random.choice(meses)           # p.e. 'VA2505'

        rut, dv = gen_rut()
        deudor = fake.name()
        direccion = fake.street_address()
        comuna = fake.city()
        direccion_lab = fake.street_address()
        comuna_lab = fake.city()
        ciudad = fake.region()
        subcartera = random.choice(["SC-A", "SC-B", "SC-C", "SC-D"])
        codigo_int = rand_code()

        registros.append((
            cliente_nombre,
            cartera_codigo,
            envio_codigo,
            rut,
            dv,
            gestor_nombre,
            deudor,
            direccion,
            comuna,
            direccion_lab,
            comuna_lab,
            ciudad,
            codigo_int,
            subcartera
        ))

    # 2) Inserción en bloque (transacción implícita con autocommit off)
    insert_sql = """
        INSERT INTO cubo (
            cliente, cartera, envio,
            rut, dv, gestor, deudor,
            direccion, comuna,
            direccion_laboral, comuna_laboral,
            ciudad, codigo, subcartera
        ) VALUES %s
    """
    execute_values(cur, insert_sql, registros)
    conn.commit()

print(f"✔  {BATCH_SIZE} registros insertados en cubo.")
