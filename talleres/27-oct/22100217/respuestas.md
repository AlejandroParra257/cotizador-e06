# Taller 5 · Composición o herencia

Nombre: Ramon Alejandro Parra Pascual
Número de control: 22100217
Equipo: E06

## Paso 1 · La herencia

**a)** El cálculo del seguro (2 % sobre la base) está escrito en `ConSeguro` y en
`RefrigeradaConSeguro`. No se pudo escribir una sola vez porque la herencia obliga a
una jerarquía lineal: `RefrigeradaConSeguro` ya hereda de `Refrigerada`, y no puede
heredar también de `ConSeguro`, así que el código del seguro se copia.

**b)** Con express, las combinaciones son: base, frío, seguro, express, frío+seguro,
frío+express, seguro+express, frío+seguro+express → **8 clases en total**.
Ya existían 4 (`Cotizacion`, `Refrigerada`, `ConSeguro`, `RefrigeradaConSeguro`),
así que hacen falta **4 clases nuevas**:
`ConExpress`, `RefrigeradaConExpress`, `ConSeguroYExpress`, `RefrigeradaConSeguroYExpress`.

## Paso 2 · La composición

**c)** Solo agregué una línea:
```typescript
export const express: Ajuste = (monto) => monto + 50000;
```
La función `cotizar` no cambió: sigue siendo un `reduce` que aplica cada ajuste en orden.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 | 153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 | 152000 |

**d)** En el primer caso express (+50 000) se aplica primero, entonces el seguro (2 %)
se calcula sobre una base más grande (150 000) y suma 3 000 más. En el segundo caso
el seguro se calcula sobre la base original (100 000) y solo suma 2 000, dejando un
total menor aunque express sume los mismos 50 000 fijos al final.

## Paso 4 · Sostén la decisión

**e)** En nuestro proyecto los pasos del cálculo están escritos con **composición**:
tablas de funciones en lugar de jerarquías de clases. El archivo es
`cotizador-06/src/modelo.ts`, funciones `cotizar` y `calcular`, con las tablas
`COMPARA`, `BASE` y `TIENE_PESO_MAXIMO`.

**f)** Usaría herencia para modelar los tipos de usuario de una aplicación:
`Usuario` → `Administrador`. Aquí no hay explosión de combinaciones porque un
administrador siempre es exactamente eso; no hay "administrador-con-permiso-x" y
"administrador-con-permiso-y" como variantes separadas: los permisos se manejan
como datos dentro del mismo objeto.