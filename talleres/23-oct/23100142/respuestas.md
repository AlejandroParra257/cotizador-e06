# Taller 4 · De condicionales a despacho

Nombre: Fernando Guadalupe Campos Villanueva

Número de control: 22100142

Equipo: E06

Copia este archivo a `talleres/23-oct/<tu número de control>/respuestas.md` en el repositorio de tu
equipo, junto con tu `despacho.ts`. Entrega: viernes 23 de octubre, 23:59.

## Paso 1 · La versión con switch

**a)** Antes de tocar nada: ¿cuántos lugares de `condicionales.ts` hay que cambiar para agregar
`perecedera`?

Cuatro, el tipo, el case de recargo, el case de etiqueta y la lista tipos de la demostración.

**b)** Después de agregar `'perecedera'` solo al tipo: ¿qué dijo `tsc`, y qué imprimió la
demostración para perecedera?

tsc no marca error. La demostración imprime perecedera 0 null General, porque cae en el default de cada switch.

**c)** ¿Por qué el compilador no te avisó? (una línea)

Porque cada switch tiene default, así que TypeScript no obliga a cubrir todos los casos.

## Paso 3 · La versión con tabla

**d)** Después de agregar `'perecedera'` al tipo: ¿qué dijo `tsc`? Copia el mensaje.

tsc marca un error (TS2741) diciendo que falta la propiedad perecedera en Record<Tipo, Politica>. Copia el mensaje exacto de tu terminal.

**e)** ¿Cuántos lugares cambiaste en `despacho.ts` para agregar perecedera?

Dos: el tipo Tipo y la entrada de POLITICAS. Las funciones no cambian.
## Los dos lenguajes

**f)** En su motor de Elixir, ¿qué pasa si llega un tipo de carga para el que no hay cláusula? ¿Y en
`despacho.ts`, si a la tabla le falta un tipo? ¿Cuál de los dos te avisa antes, y cuándo? (dos líneas)

En Elixir, si llega un tipo sin cláusula, falla en tiempo de ejecución con FunctionClauseError, solo cuando pasa ese valor. En TypeScript, si falta un tipo en la tabla, tsc avisa al compilar, antes de ejecutar nada.