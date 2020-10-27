# Implement the higher-order function that composes two functions.
# def compose[A,B,C](f: B => C, g: A => B): A => C

defmodule Compose do
  def impl(f, g) do
    fn a -> f.(g.(a)) end
  end
end

fun = Compose.impl(
  fn b -> b + 1 end,
  fn a -> a * 3 end)

IO.puts(fun.(4))
