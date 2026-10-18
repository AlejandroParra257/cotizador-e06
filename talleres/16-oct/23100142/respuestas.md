# Taller 3 · La mutación escondida

Nombre: fernando guadalupe campos villanueva
Número de control:  23100142
Equipo: 06

Copia este archivo a `talleres/16-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `escondida.ex`. Entrega: viernes 16 de octubre, 23:59.

## 1 · Antes y después de ejecutar

Llena "Predigo" **antes** de correr `npx tsx escondida.ts`. No borres las predicciones que fallaron.

| Línea | Predigo | Salió |
|---|---|---|
| 1 · | A,B false | B,A true |
| 2 · | 10 true | 10 true |
| 3 · | 1 | 2 true |
| 4 · | null false | SCT-77 false |
| 5 · | 12 15 | 15 15 |

## 2 · Qué se muta y quién se entera

| # | Función | ¿Qué línea muta, y qué cambia? | ¿Quién más se entera del cambio? |
|---|---|---|---|
| 1 | ordenarPorPeso | embarques.sort(...) modifica el orden del arreglo original | La variable lote, porque también se cambia el orden de sus elementos. |
| 2 | conDescuento | reglas.descuentoPct = pct cambia directamente el porcentaje de descuento del objeto original. | La variable base, porque también se le cambia el descuento. |
| 3 | registrar | vistos.push(id) agrega un nuevo ID al arreglo compartido, modificando su contenido. | Las variables primera y segunda, porque las dos usan la misma lista. |
| 4 | conPermiso | copia.documentos.permiso = permiso cambia el permiso dentro del objeto documentos | La variable original, porque comparte los mismos documentos con la copia. |
| 5 | fechaDeEntrega | salida.setDate(...) modifica directamente la fecha origina | La variable salida, porque también se le suman los días a su fecha. |

## 3 · Tres preguntas cortas

**a)** En la línea 4 salió `false` en `original === conP`, y aun así el original cambió. ¿Cómo es
posible? (dos líneas)

Porque la copia y el original comparten los mismos documentos, así que al cambiar uno, también cambia el otro.

**b)** ¿Por qué `registrar` no es una función pura? (una línea)

Porque modifica una lista que está fuera de la función y guarda los cambios de las llamadas anteriores.

**c)** En tus pruebas de Elixir, la última aserción de cada una revisa que el original sigue igual.
¿Por qué en Elixir esa aserción no puede fallar? (dos líneas)

Porque en Elixir no se pueden modificar los datos originales. En su lugar, se crean nuevos valores sin afectar los anteriores.