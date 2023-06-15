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

defmodule HwPrimes do
  # Calculate the sum of all primes up to the given limit sequentially
  def sum_primes(start, finish) do
    start..finish
    |> Enum.filter(&is_prime/1)
    |> Enum.sum()
  end

  # Calculate the sum of all primes up to the given limit in parallel using multiple threads
  def sum_primes_parallel(start, finish, threads) do
    ranges = make_ranges(start, finish, threads)
    ranges
    |> Enum.map(&Task.async(fn -> sum_primes_range(&1) end))
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()
  end

  # Calculate the sum of primes within a given range
  def sum_primes_range({start, finish}) do
    start..finish
    |> Enum.filter(&is_prime/1)
    |> Enum.sum()
  end

  # Check if a number is prime
  defp is_prime(n) when n <= 1, do: false
  defp is_prime(2), do: true
  defp is_prime(n) do
    divisors = 2..trunc(:math.sqrt(n))
    Enum.all?(divisors, fn x -> rem(n, x) != 0 end)
  end

  # Divide the range of numbers into sub-ranges for parallel processing
  defp make_ranges(start, finish, cores) do
    elements_amount = div(finish - start, cores) + 1
    ranges = Enum.chunk_every(start..finish, elements_amount)
    do_make_ranges(ranges, [])
  end
  
  # Convert the list of sub-ranges into a list of tuples representing the start and end of each range
  defp do_make_ranges([], res), do: Enum.reverse(res)
  defp do_make_ranges([head | tail], res), do: do_make_ranges(tail, [{List.first(head), List.last(head)} | res])
end

IO.puts("Suma de numeros paralela")

IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 1) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 2) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 3) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 4) end))
IO.inspect(:timer.tc(fn -> Sums.total_sum(1, 1000, 5) end))

IO.puts("Suma de primos secuencial y paralela:")

IO.inspect(:timer.tc(fn -> HwPrimes.sum_primes(100) end))
IO.inspect(:timer.tc(fn -> HwPrimes.sum_primes_parallel(100, 7) end))