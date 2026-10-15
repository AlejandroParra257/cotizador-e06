# Arranque del Proyecto — Cotizador Multiparadigma

Fecha de inicio: Lunes 12 de octubre  
Materia: Programación Multiparadigma

## 1. Definición del Equipo (Paso 0)

- **A (Escribe el motor Elixir):** Ramón Alejandro Parra Pascual
- **B (Revisa PRs y aprueba):** Fernando Guadalupe Campos Villanueva

> En la Unidad 3 los roles se invertirán.

## 2. Variante Tarifaria y Cálculo a Mano (Paso 2)

**Número de Variante:** E06

**Reglas aplicadas:**

| Regla | Valor |
|---|---|
| Tarifa por km | $41.00 |
| Cuota puente Comercio Mundial | $505.00 |
| Cuota puente Colombia | $360.00 |
| Descuento por volumen | 9 % del flete, **más de 10,000 kg** |
| Recargo refrigerada | 18 % + $250.00 |
| Recargo peligrosa | 30 % + $750.00 |
| Recargo sobredimensionada | 40 % + $1,200.00 |
| Base del recargo | sobre el flete |
| Cotización mínima | $4,000.00 |
| Peso máximo | 30,000 kg |

**Cálculo a Mano — Prueba: refrigerada paga su recargo (V04)**  
Refrigerada · 5,000 kg · 240 km · Puente Comercio Mundial

| Paso | Cuenta | Centavos |
|---|---|---|
| Flete bruto | 240 × 4100 | 984,000 |
| Descuento (9 %, más de 10,000 kg: **no** aplica) | 0 | 0 |
| Flete | 984,000 − 0 | 984,000 |
| Cuota Comercio Mundial | | 50,500 |
| Recargo (18 % sobre flete + fija $250) | (984,000 × 18 + 50) div 100 + 25,000 | 202,120 |
| Total | 984,000 + 50,500 + 202,120 | **1,236,620** |

## 3. Lista de Verificación

- [ ] Saben quién es A y quién es B
- [ ] Hicieron a mano la cuenta de la prueba "refrigerada paga su recargo" de su variante
- [ ] `motor/` existe, con `lib/cotizador.ex` y `test/aceptacion_test.exs`
- [ ] `.github/workflows/motor.yml` está en la raíz y aparece en la pestaña **Actions**
- [ ] `mix test` da 16 pruebas, 15 fallas
- [ ] El PR está integrado y la liga está en Teams