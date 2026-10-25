export type Puente = 'comercio_mundial' | 'colombia';

type Datos = {
  id: string;
  pesoKg: number;
  distanciaKm: number;
  puente: Puente;
};

// Unión discriminada: una peligrosa sin numeroUn o una sobredimensionada sin permiso no se pueden escribir.
type Carga =
  | { tipo: 'general' }
  | { tipo: 'refrigerada' }
  | { tipo: 'peligrosa'; numeroUn: string }
  | { tipo: 'sobredimensionada'; permiso: string };

export type Embarque = Datos & Carga; 
export type TipoCarga = Carga['tipo'];

export type Motivo = 'peso_invalido' | 'distancia_invalida' | 'excede_peso_maximo';

export type Cotizacion = {
  id: string;
  fleteBruto: number;
  descuento: number;
  flete: number;
  cuotaPuente: number;
  recargo: number;
  ajusteMinimo: number;
  total: number;
};

// Cada estado es un tipo distinto: un borrador no tiene cotización,
// un rechazado no tiene cotización, y un despachado exige folio.
export type Borrador = { estado: 'borrador'; embarque: Embarque };
export type Cotizado = { estado: 'cotizado'; embarque: Embarque; cotizacion: Cotizacion };
export type Rechazado = { estado: 'rechazado'; embarque: Embarque; motivo: Motivo };
export type Despachado = {
  estado: 'despachado';
  embarque: Embarque;
  cotizacion: Cotizacion;
  folio: string;
};

export type Politica = { pct: number; fija: number };

export type Reglas = {
  tarifaKm: number;
  cuotaPuente: Record<Puente, number>;
  descuento: { criterio: 'a_partir_de' | 'mas_de'; umbralKg: number; pct: number };
  recargo: Record<TipoCarga, Politica>;
  baseRecargo: 'flete' | 'subtotal';
  minimo: number;
  pesoMaximoKg: number;
};

export type Resultado<T, E> = { ok: true; valor: T } | { ok: false; error: E };

const ok = (valor: Embarque): Resultado<Embarque, Motivo> => ({ ok: true, valor });
const err = (error: Motivo): Resultado<Embarque, Motivo> => ({ ok: false, error });

// Tablas en lugar de if/switch sobre el criterio, la base o el tipo de carga.
const COMPARA = {
  a_partir_de: (peso: number, umbral: number) => peso >= umbral,
  mas_de: (peso: number, umbral: number) => peso > umbral,
} as const;

const BASE = {
  flete: (flete: number, _cuota: number) => flete,
  subtotal: (flete: number, cuota: number) => flete + cuota,
} as const;

// Solo la sobredimensionada no tiene peso máximo.
const TIENE_PESO_MAXIMO: Record<TipoCarga, boolean> = {
  general: true,
  refrigerada: true,
  peligrosa: true,
  sobredimensionada: false,
};

// Porcentaje redondeado al centavo, mitades hacia arriba.
const redondeo = (monto: number, pct: number): number => Math.floor((monto * pct + 50) / 100);

function validar(e: Embarque, r: Reglas): Resultado<Embarque, Motivo> {
  if (e.pesoKg <= 0) return err('peso_invalido');
  if (e.distanciaKm <= 0) return err('distancia_invalida');
  if (TIENE_PESO_MAXIMO[e.tipo] && e.pesoKg > r.pesoMaximoKg) return err('excede_peso_maximo');
  return ok(e);
}

function calcular(e: Embarque, r: Reglas): Cotizacion {
  const fleteBruto = e.distanciaKm * r.tarifaKm;
  const { criterio, umbralKg, pct } = r.descuento;
  const descuento = COMPARA[criterio](e.pesoKg, umbralKg) ? redondeo(fleteBruto, pct) : 0;
  const flete = fleteBruto - descuento;
  const cuotaPuente = r.cuotaPuente[e.puente];
  const { pct: pctRecargo, fija } = r.recargo[e.tipo];
  const base = BASE[r.baseRecargo](flete, cuotaPuente);
  const recargo = redondeo(base, pctRecargo) + fija;
  const sinMinimo = flete + cuotaPuente + recargo;
  const total = Math.max(sinMinimo, r.minimo);
  return {
    id: e.id,
    fleteBruto,
    descuento,
    flete,
    cuotaPuente,
    recargo,
    ajusteMinimo: total - sinMinimo,
    total,
  };
}

export function cotizar(b: Borrador, r: Reglas): Cotizado | Rechazado {
  const v = validar(b.embarque, r);
  if (!v.ok) return { estado: 'rechazado', embarque: b.embarque, motivo: v.error };
  return { estado: 'cotizado', embarque: b.embarque, cotizacion: calcular(b.embarque, r) };
}

export function despachar(c: Cotizado, folio: string): Despachado {
  return { estado: 'despachado', embarque: c.embarque, cotizacion: c.cotizacion, folio };
}