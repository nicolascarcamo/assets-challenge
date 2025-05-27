// app/page.tsx
'use client';

import { useState } from 'react';
import Image from 'next/image';

type Status = 'idle' | 'success' | 'error';


export default function Home() {
  const [year, setYear]   = useState<number>(2025);
  const [month, setMonth] = useState<number>(5);
  const [msg, setMsg]     = useState<string | null>(null);
  const [status, setStatus] = useState<Status>('idle');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setMsg('Cargando…');

    const res = await fetch('/api/create-weeks', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ year, month }),
    });

    const data = await res.json();
    if (res.ok) {
      setMsg(`¡Éxito! Mes ${data.codigo} creado con sus semanas.`);
        setStatus('success');
    } else {
      setMsg(`Error: ${data.error}`);
      setStatus('error');
    }
  };

  return (
    <main className="flex flex-col items-center p-6 max-w-lg m-auto">
      <h1 className="text-2xl font-bold mb-4">Carga de Semanas por Mes</h1>

      <form onSubmit={handleSubmit} className="space-y-4 w-full">
        <div className="flex gap-4">
          <label className="flex-1">
            Año
            <input value={year}
                   onChange={e => setYear(parseInt(e.target.value))}
                   type="number" min="2000" max="2100"
                   className="border p-2 w-full"/>
          </label>

          <label className="flex-1">
            Mes
            <input value={month}
                   onChange={e => setMonth(parseInt(e.target.value))}
                   type="number" min="1" max="12"
                   className="border p-2 w-full"/>
          </label>
        </div>

        <button type="submit"
                className="bg-blue-600 text-white px-4 py-2 rounded">
          Crear
        </button>
      </form>

      {msg && <p className="mt-6">{msg}</p>}

      {status === 'success' && (
        <Image
          src="/car.gif"
          alt="Operación exitosa"
          className="mt-4"
          width={200}
          height={200}
          priority
        />
      )}

      {status === 'error' && (
        <Image
          src="/glup.jpeg"
          alt="El mes ya está registrado"
          className="mt-4"
          width={200}
          height={200}
          priority
        />
      )}

    </main>
  );
}
