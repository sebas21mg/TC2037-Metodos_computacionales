defmodule Sums do

  def range_sum({start, finish}), do: Enum.sum(start..finish)
  def range_list(start, finish), do: Enum.to_list(start..finish)

  def total_sum() do

    # Create a new process
    [{1, 400}, {401, 600}, {601, 800}, {801, 1000}]
    |> Enum.map(&Task.async(fn -> range_sum(&1) end))
    # |> IO.inspect()
    |> Enum.map(&Task.await(&1))
    # |> IO.inspect()
    |> Enum.sum()

  end

end

# IO.inspect(Sums.range_list(1, 10))
IO.puts(Sums.total_sum())