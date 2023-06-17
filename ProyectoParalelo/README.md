# <center>Resaltador de Sintaxis</center>

![Logo Tec](Assets/logoTec.png)

#### <center>Sebastian Enrique Moncada González - A01027028 </center>
#### <center>Samuel Roberto Acevedo Sandoval - A01026893 </center>

## <center>Materia: Implementación a métodos computacionales</center>

#### <center>Profesor: Gilberto Echeverria Furió</center>

## <center>16 de junio 2023</center>

## Cómo ejecutarlo y ejemplos de ejecución

```terminal
➜  ProyectoParalelo git:(main) ✗ elixir Proyecto.ex
```

Nosotros usamos 30 codigos de Python para forzar que se usaran todos los núcleos disponibles de los CPUs modernos.

Y unos de los Outputs que nos salieron fueron los siguientes:

![Ejemplo Output](Assets/OutputExample.png)

Cómo podemos observar, todos los tiempos de la secuencia paralela son menores al de ña secuencial, los valores de 1 puede variar pues es igual con 1, pero los demás siempre son con un menor tiempo que el secuencial.

Ahora, usaremos la fórmula siguiente para calcular el tiempo de ejecución:

$$ S_p = \frac{T_1}{T_p} $$

Donde:

$p$ es el número de procesadores (o núcleos)

$T_1$ es el tiempo que tarda en ejecutarse la version secuencial del programa

$T_p$ es el tiempo que tarda en ejecutarse la versi ́on paralela del programa utilizando p procesadores.

$S_p$ es el $speedup$ obtenido usando $p$ procesadores

Nosotros utilizamos 4 procesadores para nuestra suma paralela, lo que nos dio el siguiente resultado:

$$ S_4 = \frac{0.475}{0.189} ≈  2.5132275132275134$$

Al calcular el speedup, utilizando la fórmula anterior, se obtiene un valor aproximado de 2.5132275132275134.

Lo anterior significa que al utilizar 4 procesadores en el enfoque paralelo, se logró obtener un speedup de aproxima de 2.5132275132275134 veces más rápido en comparación de la secuencial. Aquí podemos apreciar el beneficio de utilizar la programación paralela y así aprovechar todo el procesamiento de múltiples núcleos para acelerar la ejecución de tareas computacionalmente intensivas.

