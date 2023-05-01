# Sebastian Moncada
# Samuel Acevedo

# 30 04 2023

defmodule Ariel2 do

    # * ===============================================================================================================
    # * 3. La función rotate_left toma dos entradas: un número entero n y una lista lst. Devuelve la lista que resulta 
    # * de rotar lst un total de n elementos a la izquierda. Si n es negativo, rota hacia la derecha.                  
    # * ===============================================================================================================

    # - Cuando la lista esta vacía
    def rotate_left([], _n), do: []

    # - Cuando es un número positivo
    def rotate_left(lst, n) when n >= 0 and n <= length(lst), do: do_positive_rotate(lst, [], [], n)
    # Si 'n' es mayor a la longitud de la lista, se obtiene su residuo para que sea éste sea 'n'
    def rotate_left(lst, n) when n >= 0 and n > length(lst), do: do_positive_rotate(lst, [], [], rem(n, length(lst)))

    # - Cuando es un número negativo 
    # Prácticamente misma lógica que cuando 'n' es positivo, de hecho multiplica 'n' por -1 para que sea positivo
    def rotate_left(lst, n) when n < 0 and -n <= length(lst), do: do_negative_rotate(lst, [], [], -n)
    def rotate_left(lst, n) when n < 0 and -n > length(lst), do: do_negative_rotate(lst, [], [], rem(-n, length(lst)))

    # Cuando la lista ya esté vacía el resultado final va ser la concatenación de los números que no se rotaron y los que sí
    defp do_positive_rotate([], non_rotated, rotated, _n), do: non_rotated ++ rotated 
    # Los 'n' primeros números de la lista se van a ir a la lista de los números rotados
    defp do_positive_rotate([head | tail], non_rotated, rotated, n) when n > 0, do: do_positive_rotate(tail, non_rotated, rotated ++ [head], n - 1)
    # Los demás números se van a ir a la lista de los números no rotados
    defp do_positive_rotate([head | tail], non_rotated, rotated, n) when n == 0, do: do_positive_rotate(tail, non_rotated ++ [head], rotated, 0)

    # Ahora los números rotados van al principio y los no rotados al final
    defp do_negative_rotate([], non_rotated, rotated, _n), do: rotated ++ non_rotated
    # Cuando ya son los últimos 'n' números de la lista se van a la lista de los números rotados
    defp do_negative_rotate([head | tail], non_rotated, rotated, n) when length(tail) < n, do: do_negative_rotate(tail, non_rotated, rotated ++ [head], n)
    # Los primeros números se van a la lista de los no rotados
    defp do_negative_rotate([head | tail], non_rotated, rotated, n) when length(tail) >= n, do: do_negative_rotate(tail, non_rotated ++ [head], rotated, n)


    # * =============================================================================================================
    # * 4. La función prime_factors toma un número entero n como entrada (n ¿ 0) y devuelve una lista que contiene   
    # * los factores primos de n en orden ascendente. Los factores primos son los números primos que dividen a un    
    # * número de manera exacta. Si se multiplican todos los factores primos se obtiene el número original.          
    # * =============================================================================================================

    # Ya que el 1 y el 0 no son números primos, cuando 'n' sea igual o menor a 1 se va a devolver una lista vacía
    def prime_factors(n) when n <= 1, do: []
    # De resto se ejecuta el programa iniciando por el 2 como el primer número primo a evaluar
    def prime_factors(n) when n > 1, do: do_prime_factors(n, 2, [])

    # Cuando 'n' ya es 1 es porque ya no tiene más números en los que se pueda dividir, así que se saca la lista de factores
    defp do_prime_factors(1, _prime, factors), do: factors
    # Mientras 'n' sea divisible por un número primo, este número se va a agregar a la lista de factores y va a dividir 'n'
    # Se usa div para que la división de un int
    defp do_prime_factors(n, prime, factors) when rem(n, prime) == 0, do: do_prime_factors(div(n, prime), prime, factors ++ [prime])
    # Si 'n' no es divisible por un número primo se le suma 1 a ese número
    defp do_prime_factors(n, prime, factors), do: do_prime_factors(n, prime + 1, factors)

    # * =============================================================================================================
    # * 5. La función gcd toma dos números enteros positivos a y b como entrada, donde a > 0 y b > 0. Devuelve el    
    # * máximo común divisor (GCD por sus siglas en inglés) de a y b. No se debe usar la función gcd o similar       
    # * predefinida.                                                                                                 
    # * =============================================================================================================

    # Si uno de los números es 0, se toma el valor del otro número
    def gcd(n1, n2) when n1 == 0, do: n2
    def gcd(n1, n2) when n2 == 0, do: n1
    # Sino se ejecuta el programa
    def gcd(n1, n2), do: compare_lsts(n1, n2)

    # Se comparan dos listas que contienen todos los divisores de los dos números hasta que haya uno en común (el mayor)
    defp compare_lsts(n1, n2), do: compare_elmnt_lst(all_dividers(n1), all_dividers(n2))

    # Encontrar todos los divisores de 'n' y organizarlos de mayor a menor para que el resultado sear el máximo comúmn divisor
    defp all_dividers(n) when n > 0, do: do_all_dividers(n, n, [])

    # Cuando el divisor ya es 0 es porque ya se calcularon todos los posible divisores, así que se obtiene la lista de divisores
    defp do_all_dividers(_n, 0, dividers), do: dividers 
    # Si el módulo de 'n' entre el divisor es 0, se agrega el divisor a la lista
    defp do_all_dividers(n, divider, dividers) when rem(n, divider) == 0, do: do_all_dividers(n, divider - 1, dividers ++ [divider]) 
    # Sino se resta uno al número divisor
    defp do_all_dividers(n, divider, dividers), do: do_all_dividers(n, divider - 1, dividers) 

    # Se va recorriendo la primera lista comparando cada elemento con la segunda lista
    defp compare_elmnt_lst([head | tail], lst2), do: compare_elmnts(head, lst2, tail, lst2)

    # Se va recorriendo la segunda listo comparando cada elemento con el elemento de la primera lista
    # Si se acaba la segunda lista y no coincidió ningún elemento, se pasa al siguiente elemento de la primera lista
    defp compare_elmnts(_n, [], lst1, lst2), do: compare_elmnt_lst(lst1, lst2)
    # Si un elemento coincide se toma como la respuesta al problema
    defp compare_elmnts(n, [head | _tail], _lst1, _lst2) when n == head, do: n
    # Mientras no se acabe la segunda lista
    defp compare_elmnts(n, [_head | tail], lst1, lst2), do: compare_elmnts(n, tail, lst1, lst2)

    # * =============================================================================================================
    # * 6. La función deep_reverse toma una lista como entrada. Devuelve una lista con los mismos elementos que su   
    # * entrada pero en orden inverso. Si hay listas anidadas, estas también deben invertirse.                       
    # * =============================================================================================================

    def deep_reverse(list), do: do_deep_reverse(list, [])

    defp do_deep_reverse([], reversed_lst), do: reversed_lst
    # Si 'head' es una lista entra de nuevo a la función con una nueva lista y cuando termina sale y sigue el recorrido en el que estaba
    defp do_deep_reverse([head | tail], reversed_lst) when is_list(head), do: do_deep_reverse(tail, [do_deep_reverse(head, []) | reversed_lst])
    # Sino siempre sigue el mismo recorrido
    defp do_deep_reverse([head | tail], reversed_lst), do: do_deep_reverse(tail, [head | reversed_lst])

end