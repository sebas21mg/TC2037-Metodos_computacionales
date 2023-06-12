defmodule Sums do

  def range_sum({start, finish}), do: Enum.sum(start..finish)

  def make_ranges(start, finish, cores) do
    elements_amount = div(finish - start, cores) + 1
    ranges = Enum.chunk_every(start..finish, elements_amount)
    do_make_ranges(ranges, [])
  end

  def do_make_ranges([], res), do: Enum.reverse(res)
  def do_make_ranges([head | tail], res), do: do_make_ranges(tail, [{List.first(head), List.last(head)} | res])

  def total_sum(start, finish, cores) do
    # Create a list of tuples to send to the function
    make_ranges(start, finish, cores)
    |> Enum.map(&Task.async(fn -> range_sum(&1) end)) # Create a new process
    # |> IO.inspect()
    |> Enum.map(&Task.await(&1))
    # |> IO.inspect()
    |> Enum.sum()
  end

end

IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 1) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 2) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 3) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 4) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 5) end))