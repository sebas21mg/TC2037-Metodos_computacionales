defmodule Repaso do
    def multipliedByIndex(lst), do: do_multipliedByIndex(lst, 1, [])

    defp do_multipliedByIndex([], _index, res), do: Enum.reverse(res)
    defp do_multipliedByIndex([head | tail], index, res), do: do_multipliedByIndex(tail, index + 1, [(head * index) | res])


    def endsWith4(lst), do: do_endsWith4(lst, [])

    defp do_endsWith4([], res), do: Enum.reverse(res)
    defp do_endsWith4([head | tail], res) when rem(head, 10) == 4, do: do_endsWith4(tail, [head | res])
    defp do_endsWith4([head | tail], res) when rem(head, 10) != 4, do: do_endsWith4(tail, res)
end

IO.inspect(Repaso.multipliedByIndex([5, 2, 9, 4, 2]))
IO.inspect(Repaso.endsWith4([104, 8, 29, 4, 58, 93754, 93, 24]))