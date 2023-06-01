# Resaltador de Sintaxis

#### Sebastian Enrique Moncada González - A01027028
#### Samuel Roberto Acevedo Sandoval - A01026893

- Cómo se ejecuta el código

Para ejecutar el código solo ocupamos ejecutar la siguiente línea en la terminal (dento de la carpeta donde estén los archivos):

```terminal
➜  Proyecto git:(main) ✗ elixir Proyecto.ex
```

En este caso nosotros los probamos con unos códigos de prueba, teniendo cómo resultados los siguientes:



6. Reflexiona sobre la solución planteada, los algoritmos implementados y sobre el tiempo de ejecución de estos.

Pensar en cómo realizar el resaltador de sintaxis fue un verdadero reto, pues tuvimos que juntar muchas de las cosas que hemos aprendido a lo largo del semestre y unirlas para poder llegar al resultado esperado, teniendo en cuenta los requerimientos que se pidieron y realizandolos de manera exitosa.

La solución final presentada tiene mucho de lo visto en este semestre, teniendo métodos como la recursividad, expresiones regulares entre muchos otros.

Tratamos de que el tiempo de ejecución fuese lo más rápido posible, y sobre tratamos de adaptar el código más a esto, econtrandonos con varias dificultades pero así teniendo un código más óptimo y eficiente.

7. Calcula la complejidad de tu algoritmo basada en el número de iteraciones y contrástala con el tiempo estimado en el punto anterior.

Se presentara la complejidad del código y para poder determinar esta lo iremos haciendo función por función.

#### Función "classes"
```elixir
def classes do
    [
      [~r/^(#.*)/, "comentario"],
      [~r/^("(.*?)"|'(.*?)')/, "cadena-texto"],
      [~r/^(\+|\-|\*|\/|\%|\=|\<|\>|\^)/, "signo"], 
      [~r/^(\(|\)|\[|\]|\{|\})/, "parentesis"], 
      [~r/^(def|return|import|for|if|in|row|with|while|elif|else)/, "palabras-reservada"], 
      [~r/^([\w_]+)\s*(?=\()/, "funcion"], 
      [~r/^([\w_]+)/, "variable"]
    ]
  end
```
La complejidad de esta función es O(1), pues no hay bucles ni operaciones que dependan del tamaño de los datos de entrada.

Tomando la complejidad más grande podemos decir que su complejidad es de: 
$$O(1)$$

#### Función "replaceLine" y "do_replace_line"
```elixir
def replaceLine(line), do: do_replaceLine(line, "", classes(), classes())

  defp do_replaceLine("", newLine, _, _), do: newLine

  defp do_replaceLine(line, newLine, [], classes), do: do_replaceLine(
    Regex.replace(~r/^(.|\n)/, line, ""), 
    newLine <> Enum.at( Regex.run(~r/^(.|\n)/, line) , 0), 
    classes, 
    classes)

  defp do_replaceLine(line, newLine, [head | tail], classes) do
    regex = Enum.at(head, 0)
    class = Enum.at(head, 1)

    if Regex.match?(regex, line) do
      newLine = newLine <> "<span class='"<> class <> "'>" <> Enum.at(Regex.run(regex, line), 0) <> "</span>"
      line = Regex.replace(regex, line, "") 
      do_replaceLine(line, newLine, classes, classes)

    else
      do_replaceLine(line, newLine, tail, classes)

    end
  end
```
La función "replaceLine" solo llama a la función "do_replaceLine", por lo que su complejidad depende de la complejodad de "do_replaceLine".

La función "do_replaceLine("", newLine, _, _)" es un caso base para detener la recursión cunado la línea de entrada esté vacía. No se realiza ninguna operación adicional, por lo que su complejidad es constante O(1).

La función "do_replaceLine(line, newLine, [], classes)" reemplaza el primer carácter de la línea de entrada y se agrega al primer grupo coincidente a la nueva línea. Posteriormente se realiza una llamada recursiva a la función do_replaceLine con los mismos argumentos. La complejidad de esta igual es constante O(1), pues no depende del tamaño de linea o del numero de clases.

La función "do_replaceLine(line, newLine, [head | tail], classes)" verifica si hay un patron en la búsqueda y la línea de entrada, si es que llega a existir se agrega la parte coincidente a la nueva línea y se realiza el reemplazo en la línea original. Posteriormente se hace una llamada recursiva a la función con los mismos argumentos, con la excepción de que se pasa la cola (tail) en lugar del primer elemento. En este caso la complejidad de esta función depende del número de clases que hay en la función "classes", pues esta realizará una iteración por cada clase, por lo que la complejidad será lineal O(n).

Tomando la complejidad más grande podemos decir que su complejidad es de: 
$$O(n)$$

#### Función "highlightSyntax"

```elixir
def highlightSyntax(inFilePath, outFilePath) do
    fileName = inFilePath |> Path.basename()

    fileContent = inFilePath 
      |> File.stream!() # Tomar las líneas del archivo
      |> Enum.map(&replaceLine(&1)) # Hacer el cifrado
      |> Enum.join("") # Juntar todas las líneas

    File.write(outFilePath, Enum.join([@htmlBeforeTitle, fileName, @htmlAfterTitle, fileContent, @htmlEnd]))
  end
```
Esta función primero lee el archivo de entrada línea por línea, esto tiene una complejidad lineal O(m) pues depende del tamaño del archivo, donde "m" es la cantidad de líneas en el archivo.
Luego aplica la función "replaceLine" a cada línea del archivo, su complejidad depende de la cantidad total de líneas del archivo y de la complejidad de "replaceLine", la cuál es O(n).
Posteriormente une todas las líneas del archivo en una sola cadena, donde tiene una complejidad de O(k), donde "k" es la longitud total del contenido.
Por último, escribe el contenido en el archivo de salida, su complejidad nuevamente depende del tamaño del contenido, donde "k" es la longitud total del contenido.

Tomando la complejidad más grande podemos decir que su complejidad es de: 
$$O(m*n + 2k)$$

Complejidad del código completo:
Para determinar la complejidad total del código agarramos la complejidad más alta de este, que en nuestro caso es:
$$O(m*n + 2k)$$
Siendo esta nuestra complejidad para el código.

8. Plasma en un breve reporte de una página (en formato Markdown) las conclusiones de tu reflexión en los puntos 6 y 7. Agrega además una breve reflexión sobre las implicaciones éticas que el tipo de tecnología que desarrollaste pudiera tener en la sociedad.

La solución planteada para el resaltador de sintaxis fue un desafío interesante y nos dio la oportunidad de aplicar varios conceptos aprendidos. Principalmente logramos combinar efectivamente diferentes elementos, cómo la recursividad y las expresiones regulares, llegando al resultado esperado.

También consideramos que el resaltador de sintaxis tiene varias implicaciones éticas que tomar en cuenta, cómo lo es la responsabilidad en el uso esta herramienta. Por ejemplo, el resaltado de sintaxis no debe de utilizarse para copiar el trabajo de otros sin su consentimiento, además de asegurarnos de que el código no se utilice de manera erronea, cómo lo podría ser engañar o manipular a los usuarios.

Es esencial promover un uso responsable y ético de estas herramientas y así con constribuir a un entorno tecnológico más equitativo y confiable.