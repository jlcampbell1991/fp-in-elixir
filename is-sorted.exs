# Implement isSorted, which checks whether an Array[A] is sorted according to a
# given comparison function.

defmodule IsSorted do
  def impl([h | t], is_ordered?) do
    impl(t, h, is_ordered?, false)
  end

  defp impl([], _, _, is_sorted?) do
    is_sorted?
  end

  defp impl([h_1 | t], h_2, is_ordered?, is_sorted?) do
    if is_ordered?.(h_2, h_1) do
      impl(t, h_1, is_ordered?, true)
    else
      is_sorted?
    end
  end
end

IO.puts(IsSorted.impl([1,2,3,4,5], fn a, b -> a < b end))
