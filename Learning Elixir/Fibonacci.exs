# Sebastian Moncada
# 20 04 2023

# Create a new module. All module names must start with Uppercase
defmodule Recur do

    # * Get the fibonacci number at the specified index, using tail recursion

    def fibo_tail(n) when n < 0, do: {:error, :negative}
    def fibo_tail(0), do: {:ok, 0}
    def fibo_tail(1), do: {:ok, 1}
    def fibo_tail(n), do: {:ok, do_fibo_tail(0, 1, n - 1)}

    # Private function to do the recursion

    defp do_fibo_tail(a, b, 0), do: b # defp es que la función es privada
    defp do_fibo_tail(a, b, n), do: do_fibo_tail(b, a + b, n - 1)

end
