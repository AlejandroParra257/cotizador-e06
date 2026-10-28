# Taller 5 · Composición o herencia

Nombre: Campos villanuea Fernando Guadalupe

Número de control: 23100142

Equipo: 06

## Paso 1 · La herencia

**a)** ¿En qué dos clases está escrito el cálculo del seguro? ¿Por qué no se pudo escribir una sola
vez?

en las clases ConSeguro y RefrigeradaConSeguro, no se puede escribir una sola vez porque TypeScript solo permite heredar de una clase,así que RefrigeradaConSeguro no puede heredar del frío y del seguro a la vez, y tiene que copiar el cálculo.  

**b)** Con un tercer extra (express), ¿cuántas clases hacen falta para todas las combinaciones?
¿Cuántas son nuevas? Muestra la cuenta.

con tres extras seria 8 combinaciones, asi que 8 clases en total y como se ven en herencia hay 4 y nuevas 4 (express solo, frío + express, seguro + express y los tres).

## Paso 2 · La composición

**c)** Para agregar express a `composicion.ts`, ¿qué agregaste? ¿Cambió `cotizar`?

express es una función más que suma un monto fijo, y cotizar no cambió.

## Paso 3 · El orden

| Llamada | Predigo | Salió |
|---|---|---|
| `cotizar(100, 1000, [express, seguro])` | 153000 |153000 |
| `cotizar(100, 1000, [seguro, express])` | 152000 |152000 |

**d)** ¿Por qué salen distintos? (dos líneas)

El seguro se calcula sobre el monto que hay al momento de aplicarlo. Si express va antes, ese monto incluye los $500 y el seguro sale más caro.
## Paso 4 · Sostén la decisión

**e)** En su modelo del proyecto, ¿cómo están escritos los pasos del cálculo: con herencia o con
composición? Cita el archivo y la función.

El cálculo está escrito con composición: calcular usa funciones y tablas (COMPARA, BASE, redondeo) que se combinan en orden, no con clases que se extienden.

**f)** Da **un** caso, en su proyecto o fuera de él, donde sí usarías herencia, y di por qué ahí no
hay explosión de combinaciones. (tres líneas)

Un sistema de vehículos sería un buen caso para herencia: Coche, Camion y Motocicleta son tipos de Vehiculo (relación “es un”) y la única variación es el tipo de vehículo. No hay que combinar otras dimensiones, así que no se multiplican las clases.