# Actividad 5.2 Programación paralela y concurrente.
## Sebastian Moncada
## Samuel Acevedo

Tiempo de ejecución de suma de número primos secuencial de hasta 5,000,000: 18852521 milliseconds
Tiempo de ejecución de suma de números primos paralela de hasta 5,000,000: 8816575 milliseconds

Siguiendo la formula:
$$ S_p = \frac{T_1}{T_p} $$

Donde:

$p$ es el número de procesadores (o núcleos)

$T_1$ es el tiempo que tarda en ejecutarse la version secuencial del programa

$T_p$ es el tiempo que tarda en ejecutarse la versi ́on paralela del programa utilizando p procesadores.

$S_p$ es el $speedup$ obtenido usando $p$ procesadores

Nosotros utilizamos 4 procesadores para nuestra suma paralela, lo que nos dio el siguiente resultado:

$$ S_4 = \frac{18852521}{8816575} ≈ 2.138158 $$

Al comparar los tiempos de ejecución entre la versión secuencial y paralela del programa para la suma de números primos hasta 5,000,000, se observa una reducción significativa en el tiempo de ejecución de la versión paralela. El tiempo de ejecución secuencial fue de 18852521 milisegundos, mientras que el tiempo de ejecución paralela fue de 8816575 milisegundos.

Al calcular el speedup, utilizando la fórmula anterior, se obtiene un valor aproximado de 2.138158.

Esto significa que al utilizar 4 procesadores en el enfoque paralelo, se logró obtener un speedup de aproximadamente 2.138158 veces más rápido en comparación con la ejecución secuencial. Esto demuestra el beneficio de utilizar la programación paralela y aprovechar el poder de procesamiento de múltiples núcleos para acelerar la ejecución de tareas computacionalmente intensivas.