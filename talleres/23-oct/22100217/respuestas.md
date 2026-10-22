# Taller 4 · De condicionales a despacho

Nombre: Ramon Alejandro Parra Pascual
Número de control: 22100217
Equipo: E06

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.

## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`?

4 lugares: el tipo `Tipo` y los tres `switch` (uno en `recargo`, uno en `documentoRequerido`, uno en `etiqueta`).

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera?

`tsc` no reportó ningún error. La demostración imprimió `perecedera  0  null  General`, porque los tres `switch` tienen un `default` que silenciosamente retorna los valores de la carga general.

**c)** ¿Por qué el compilador no te avisó? (una línea)

Porque los `switch` tienen `default`, así que TypeScript considera que todos los casos están cubiertos aunque el tipo nuevo no tenga su propio `case`.

## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.

Error: Property 'perecedera' is missing in type '{ general: Politica; refrigerada: Politica; peligrosa: Politica; sobredimensionada: Politica; }' but required in type 'Record<Tipo, Politica>'.

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?

1 solo lugar: agregar la entrada `perecedera` en la tabla `POLITICAS`.

## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)

En Elixir lanza un `FunctionClauseError` en tiempo de ejecución cuando llega el tipo sin cláusula. En `despacho.ts`, `Record<Tipo, Politica>` hace que `tsc` falle en tiempo de compilación si falta un tipo en la tabla. TypeScript avisa antes: el error aparece antes de ejecutar el programa.