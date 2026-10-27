export type Ajuste = (monto: number) => number;

const pct = (monto: number, p: number): number => Math.floor((monto * p + 50) / 100);

const EXPRESS_CENTAVOS = 500 * 100;

export const frio: Ajuste = (monto) => monto + pct(monto, 18);
export const seguro: Ajuste = (monto) => monto + pct(monto, 2);
export const express: Ajuste = (monto) => monto + EXPRESS_CENTAVOS;

export function cotizar(km: number, tarifaKm: number, ajustes: readonly Ajuste[]): number {
  return ajustes.reduce((acc, ajuste) => ajuste(acc), km * tarifaKm);
}