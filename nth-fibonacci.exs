# Write a recursive function to get the nth Fibonacci number (http://mng.bz/C29s).
# The first two Fibonacci numbers are 0 and 1. The nth number is always the sum of
# the previous two—the sequence begins 0, 1, 1, 2, 3, 5. Your definition should
# use a local tail-recursive function.


defmodule Fib do
  def fib(n) do
    fib(n, 0, 1, 0)
  end

  def fib(n, prev, current, i) do
    if i < n do
      fib(n, current, prev + current, i + 1)
    else
      prev + current
    end
  end
end

IO.puts(Fib.fib(8))
