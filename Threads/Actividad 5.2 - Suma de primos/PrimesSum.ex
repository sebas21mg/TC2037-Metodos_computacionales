# Sebastian Moncada
# Samuel Acevedo

# Program that calculates sequentally and parallel the sum of the prime numbers between 1 and 5,000,000

defmodule Hw.Primes do

  # Check if a number is prime
  defp is_prime(n) when n < 2, do: false
  defp is_prime(n) when n == 2, do: true
  defp is_prime(n), do: Enum.all?(2..round(:math.sqrt(n)), fn i -> rem(n, i) != 0 end)

  # Divide the range of numbers into sub-ranges for parallel processing
  defp make_ranges(start, finish, cores) do
    elements_amount = div(finish - start, cores) + 1
    ranges = Enum.chunk_every(start..finish, elements_amount)
    do_make_ranges(ranges, [])
  end
  
  # Convert the list of sub-ranges into a list of tuples representing the start and end of each range
  defp do_make_ranges([], res), do: Enum.reverse(res)
  defp do_make_ranges([head | tail], res), do: do_make_ranges(tail, [{List.first(head), List.last(head)} | res])

  # Calculate the sum of primes within a given range
  defp sum_primes_range({start, finish}) do
    start..finish
      |> Enum.filter(&is_prime/1)
      |> Enum.sum()
  end

  # Calculate the sum of all primes up to the given limit sequentially
  def sum_primes(finish), do: sum_primes_range({1, finish})

  def sum_primes_parallel(finish, threads) do
    make_ranges(1, finish, threads)
      |> Enum.map(&Task.async(fn -> sum_primes_range(&1) end))
      |> Enum.map(&Task.await(&1, 10000))
      |> Enum.sum()
  end

end

IO.puts("Suma de primos secuencial:")
t1 = :timer.tc(fn -> Hw.Primes.sum_primes(5_000_000) end) |> IO.inspect()

IO.puts("Suma de primos paralela:")
tp = :timer.tc(fn -> Hw.Primes.sum_primes_parallel(5_000_000, 4) end) |> IO.inspect()

IO.puts("Speedup con 4 procesadores:")
elem(t1, 0) / elem(tp, 0) |> Float.round(4) |> IO.puts()