# Sebastian Moncada
# 20 04 2023

defmodule Listas do

    # - Ejercicio 10
    def positives(list), do: do_positives(list, [])

    defp do_positives([], res), do: Enum.reverse(res)
    defp do_positives([head | tail], res) when head >= 0, do: do_positives(tail, [head | res])
    defp do_positives([head | tail], res) when head < 0, do: do_positives(tail, res)

    # - Ejercicio 12
    def invert_pairs(list), do: do_invert_pairs(list, [])

    defp do_invert_pairs([], res), do: Enum.reverse(res)
    defp do_invert_pairs([[f, s] | tail], res), do: do_invert_pairs(tail, [[s, f] | res])

    # - Ejercicio 14
    def swapper(a, b, list), do: do_swapper(a, b, list, [])

    defp do_swapper(_a, _b, [], res), do: Enum.reverse(res)
    defp do_swapper(a, b, [head | tail], res) when head == a, do: do_swapper(a, b, tail, [b | res])
    defp do_swapper(a, b, [head | tail], res) when head == b, do: do_swapper(a, b, tail, [a | res])
    defp do_swapper(a, b, [head | tail], res), do: do_swapper(a, b, tail, [head | res])

end

IO.puts("Positives:")
IO.inspect(Listas.positives([]))
IO.inspect(Listas.positives([12, -4, 3, -1, -10, -13, 6, -5]))
IO.inspect(Listas.positives([-4, -1, -10, -13, -5]))

IO.puts("\nInvert pairs:")
IO.inspect(Listas.invert_pairs([[1, 10], [2, 20], [3, 30], [4, 40]]))
IO.inspect(Listas.invert_pairs([["a", 10], ["b", 20], ["c", 30], ["d", 40]]))

IO.puts("\nSwapper:")
IO.inspect(Listas.swapper(1, 2, []))
IO.inspect(Listas.swapper(1, 2, [4, 4, 5, 2, 4, 8, 2, 5, 6, 4, 5, 1, 9, 5, 9, 9, 1, 2, 2, 4]))
IO.inspect(Listas.swapper(1, 2, [4, 3, 4, 9, 9, 3, 3, 3, 9, 9, 7, 9, 3, 7, 8, 7, 8, 4, 5, 6]))