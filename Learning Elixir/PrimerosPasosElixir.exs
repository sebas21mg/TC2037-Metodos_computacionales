# Sebastian Moncada
# 17 04 2023

# Create a new module. All module names must start with Uppercase
defmodule Recur do

    # Create a function. All function name must start with lowercase
    # def fact(n) do
    #     if n == 0 do
    #         1
    #     else
    #         n * fact(n - 1)
    #     end
    # end

    # Using Pattern Matching
    def fact(0), do: 1
    def fact(n), do: n * fact(n - 1)

    # Tail recursion
    def fact_tail(n), do: do_fact_tail(n, 1)

    defp do_fact_tail(n, r) when n < 1, do: r
    defp do_fact_tail(n, r), do: do_fact_tail(n - 1, r * n)

    # Fibonacci (using pattern matching)
    def fibo(0), do: 0
    def fibo(1), do: 1
    def fibo(n), do: fibo(n - 1) + fibo(n - 2)

    def test(a, b) do
        c = a * b
        cond do
            c > 0 -> "good"
            c < -10 -> "ok"
        end
    end

end
