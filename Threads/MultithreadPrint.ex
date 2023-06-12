# Using tasks to launch several processes at the same time

defmodule Concur do

  def test_function(id) do
    IO.puts("I am #{id}")
  end

  def main() do
    IO.puts("MAIN THREAD STARTING")

    # Create a new process
    id1 = Task.async(fn -> test_function("One") end)
    id2 = Task.async(fn -> test_function("Two") end)
    id3 = Task.async(fn -> test_function("Three") end)

    Task.await(id1) 
    Task.await(id2)
    Task.await(id3)

    IO.puts("MAIN THREAD FINISHING")
  end

  def main2() do
    IO.puts("MAIN THREAD STARTING")

    # Create a new process
    ["One", "Two", "Three", "Four"]
    |> Enum.map(&Task.async(fn -> test_function(&1) end))
    # |> IO.inspect()
    |> Enum.map(&Task.await(&1))
    # |> IO.inspect()

    IO.puts("MAIN THREAD FINISHING")
  end

end

Concur.main()

