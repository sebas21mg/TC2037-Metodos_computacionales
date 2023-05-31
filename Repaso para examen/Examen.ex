defmodule Listas do
  def inverso(lst), do: do_inv(lst, [])
  defp do_inv([], res), do: Enum.reverse(res)
  defp do_inv([head | tail], res), do: do_inv(tail, [(1/head) | res])
end

IO.inspect(Listas.inverso([1, 5, 3, 9]))