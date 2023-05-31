defmodule Listas do
    
    def multiplos3(lst), do: do_mult(lst, [])
    defp do_mult([], res), do: Enum.reverse(res)
    defp do_mult([head | tail], res) when rem(head, 3) == 0, do: do_mult(tail, [head | res])
    defp do_mult([_ | tail], res), do: do_mult(tail, res)

    def cubo(lst), do: do_cubo(lst, [])
    defp do_cubo([], res), do: Enum.reverse(res)
    defp do_cubo([head | tail], res), do: do_cubo(tail, [head * head * head | res])

end

IO.inspect(Listas.multiplos3([28, 37, 23, 12, 9, 482, 44, 29, 24]))
IO.inspect(Listas.cubo([8, 2, 5, 3, 1]))