# Sebastian Moncada
# 20 04 2023

defmodule Listas do

    # La función positives toma una lista de n ́umeros lst como entrada y devuelve una nueva lista que solo contiene los n ́umeros positivos de lst

    def positives(list), do: do_positives(list, [])

    defp do_positives([], res), do: Enum.reverse(res)
    defp do_positives([head | tail], res) when head >= 0, do: do_positives(tail, [head | res])
    defp do_positives([head | tail], res) when head < 0, do: do_positives(tail, res)

    # La funci ́on invert-pairs toma como entrada una lista cuyo contenido son listas de dos elementos. Devuelve una nueva lista con cada pareja invertida.

    def invert_pairs(list), do: do_invert_pairs(list, [])

    defp do_invert_pairs([], res), do: Enum.reverse(res)
    defp do_invert_pairs([[f, s] | tail], res), do: do_invert_pairs(tail, [[s, f] | res])
    # Listas.invert_pairs([[1, 10], [2, 20], [3, 30], [4, 40]])

    # La hice antes de que la hicieras con todos

    # El funci ́on swapper toma tres entradas: dos valores a y b, y una lista lst. Devuelve una nueva lista en la que cada ocurrencia de a en lst se intercambia por b, y viceversa. Cualquier otro elemento de lst permanece igual. Se puede suponer que lst no contiene listas anidadas.

    def swapper(a, b, list), do: do_swapper(a, b, list, [])

    defp do_swapper(a, b, [], res), do: Enum.reverse(res)
    defp do_swapper(a, b, [head | tail], res) when head == a, do: do_swapper(a, b, tail, [b | res])
    defp do_swapper(a, b, [head | tail], res) when head == b, do: do_swapper(a, b, tail, [a | res])
    defp do_swapper(a, b, [head | tail], res), do: do_swapper(a, b, tail, [head | res])
    # Listas.swapper(1, 2, [4, 4, 5, 2, 4, 8, 2, 5, 6, 4, 5, 1, 9, 5, 9, 9, 1, 2, 2, 4])

end
