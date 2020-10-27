# Implement isSorted, which checks whether an Array[A] is sorted according to a
# given comparison function.

defmodule IsSorted do
  def impl(as, ordered, isSorted) do
    case as do
      [h_1 | t] ->
        case t do
          [_ | []] ->
            isSorted
          [h_2 | _] ->
            if ordered.(h_1, h_2) do impl(t, ordered, true)
            else false end
          end
    end
  end
end

IO.puts(IsSorted.impl([1,2,3,4,5], fn a, b -> a < b end, false))
