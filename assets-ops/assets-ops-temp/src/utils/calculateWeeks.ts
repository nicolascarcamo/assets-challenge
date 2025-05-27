// utils/calculateWeeks.ts

function isBusinessDay(date: Date) {
  const day = date.getDay();          // 0=Dom, 6=Sab
  return day !== 0;
}

export interface WeekDef {
  numero_semana: number;
  fecha_inicio: Date;
  fecha_fin: Date;
  dias_habiles: number;
}

/**
 * Devuelve las 4 semanas de un mes según reglas del requerimiento.
 * @param year 4 dígitos
 * @param month 1-12 (NOTA: JS month indexado desde 1 aquí)
 */
export function buildWeeks(year: number, month: number): WeekDef[] {
  const first = new Date(year, month - 1, 1);
  const last  = new Date(year, month, 0);                // último día

  // ——— semana 4
  const w4Fin = last;
  const w4Ini = new Date(w4Fin);
  w4Ini.setDate(w4Fin.getDate() - 6);

  // ——— semana 3
  const w3Fin = new Date(w4Ini);
  w3Fin.setDate(w3Fin.getDate() - 1);
  const w3Ini = new Date(w3Fin);
  w3Ini.setDate(w3Fin.getDate() - 6);

  // ——— semana 2
  const w2Fin = new Date(w3Ini);
  w2Fin.setDate(w2Fin.getDate() - 1);
  const w2Ini = new Date(w2Fin);
  w2Ini.setDate(w2Fin.getDate() - 6);

  // ——— semana 1
  const w1Ini = first;
  const w1Fin = new Date(w2Ini);
  w1Fin.setDate(w2Ini.getDate() - 1);

  const ranges: [Date, Date][] = [
    [w1Ini, w1Fin], [w2Ini, w2Fin], [w3Ini, w3Fin], [w4Ini, w4Fin]
  ];

  return ranges.map(([ini, fin], idx) => {
    let habiles = 0;
    for (let d = new Date(ini); d <= fin; d.setDate(d.getDate() + 1)) {
      if (isBusinessDay(d)) habiles++;
    }
    return { numero_semana: idx + 1, fecha_inicio: new Date(ini), fecha_fin: new Date(fin), dias_habiles: habiles };
  });
}
