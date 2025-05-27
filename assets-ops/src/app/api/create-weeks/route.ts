// app/api/create-weeks/route.ts
import { NextResponse } from 'next/server';
import { query, withTransaction } from '@/lib/db';
import { buildWeeks } from '@/utils/calculateWeeks';

interface Body { year: number; month: number }

export async function POST(req: Request) {
  try {
    const body: Body = await req.json();
    const { year, month } = body;

    if (!year || !month || month < 1 || month > 12) {
      return NextResponse.json({ error: 'Parámetros inválidos.' }, { status: 400 });
    }

    /* 1. Comprobar si YA existe el mes (codigo VA<YYMM>) */
    const yy = String(year).slice(-2);
    const mm = String(month).padStart(2, '0');
    const codigoMes = `VA${yy}${mm}`;

    const [existe] = await query<{ id: number }>(
      'SELECT id FROM meses WHERE codigo = $1',
      [codigoMes]
    );
    if (existe) {
      return NextResponse.json({ error: 'El mes ya existe.' }, { status: 409 });
    }

    const fechaInicioMes = new Date(year, month - 1, 1);
    const semanas = buildWeeks(year, month);

    /* 2. Transacción: insertar mes + 4 semanas */
    await withTransaction(async (client) => {
      const insertMes = await client.query<{ id: number }>(
        `INSERT INTO meses (codigo, fecha_inicio)
         VALUES ($1, $2) RETURNING id`,
        [codigoMes, fechaInicioMes]
      );
      const idMes = insertMes.rows[0].id;

      const insertWeekText = `
        INSERT INTO semanas (dias_habiles, id_mes, fecha_inicio, fecha_fin, numero_semana)
        VALUES ($1, $2, $3, $4, $5)`;

      for (const w of semanas) {
        await client.query(insertWeekText, [
          w.dias_habiles,
          idMes,
          w.fecha_inicio,
          w.fecha_fin,
          w.numero_semana
        ]);
      }
    });

    return NextResponse.json({ ok: true, codigo: codigoMes });
  } catch (err: any) {
    console.error(err);
    return NextResponse.json({ error: 'Error interno.' }, { status: 500 });
  }
}
