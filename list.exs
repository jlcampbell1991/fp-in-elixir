defmodule MyList do
  # Implement the function tail for removing the first element of a List.
  # Note that the function takes constant time. What are different choices you
  # could make in your implementation if the List is Nil? We’ll return to this
  # question in the next chapter.
  def get_tail([_ | t]) do
    t
  end

  # Using the same idea, implement the function setHead for replacing the first
  # element of a List with a different value.
  def set_head([_ | t], h) do
    [h | t]
  end

  # Generalize tail to the function drop, which removes the first n elements from
  # a list. Note that this function takes time proportional only to the number of
  # elements being dropped—we don’t need to make a copy of the entire List.
  # def drop[A](l: List[A], n: Int): List[A]
  def drop([_ | t], n) do
    drop(t, n, 1)
  end

  defp drop([_ | t], n, i) when i < n do
    drop(t, n, i + 1)
  end

  defp drop(l, _, _) do
    l
  end

  # Not everything works out so nicely. Implement a function, init, that returns a
  # List consisting of all but the last element of a List. So, given List(1,2,3,4),
  # init will return List(1,2,3). Why can’t this function be implemented in
  # constant time like tail?
  # def init[A](l: List[A]): List[A]
  def init([h | t]) do
    init(t, [h])
  end

  # accum ++ [h] is not optimized for LinkedList
  defp init([h | [_ | []]], accum) do
    accum ++ [h]
  end

  # accum ++ [h] is not optimized for LinkedList
  defp init([h | t], accum) do
    init(t, accum ++ [h])
  end

  # Can product, implemented using foldRight, immediately halt the recursion and
  # return 0.0 if it encounters a 0.0? Why or why not? Consider how any
  # short-circuiting might work if you call foldRight with a large list. This is a
  # deeper question that we’ll return to in chapter 5.
  def product(l) do
    List.foldr(l, 1,
      fn i, accum ->
        if i != 0 do
          accum * i
        else 0
        end
      end)
  end

  # Compute the length of a list using foldRight.
  # def length[A](as: List[A]): Int
  def length(l) do
    List.foldr(
      l,
      0,
      fn _, accum -> accum + 1 end
    )
  end

  # Our implementation of foldRight is not tail-recursive and will result in a
  # StackOver- flowError for large lists (we say it’s not stack-safe). Convince
  # yourself that this is the case, and then write another general list-recursion
  # function, foldLeft, that is tail-recursive, using the techniques we discussed
  # in the previous chapter. Here is its signature:
  # def foldLeft[A,B](as: List[A], z: B)(f: (B, A) => B): B
  def fold_left([h | t], accum, fun) do
    fold_left(t, fun.(accum, h), fun)
  end

  def fold_left([], accum, _) do
    accum
  end

  # Write a function that returns the reverse of a list (given List(1,2,3) it
  # returns List(3,2,1)). See if you can write it using a fold.
  def reverse(l) do
    fold_left(
      l,
      [],
      fn accum, a -> [a | accum] end
    )
  end


  # Implement append in terms of either foldLeft or foldRight.
  def append(l, a) do
    List.foldr(
      l,
      a,
      fn accum, a -> [accum | a] end
    )
  end

  # Write a function that concatenates a list of lists into a single list. Its
  # runtime should be linear in the total length of all lists. Try to use
  # functions we have already defined.
  def flatten(l) do
    flatten(l, [])
  end

  defp flatten([h | t], accum) do
    case h do
      [_ | _] -> flatten(t, flatten(h, accum))
      a ->       flatten(t, [accum | a])
    end
  end

  defp flatten([], accum) do
    accum
  end

  # Write a function that transforms a list of integers by adding 1 to each element.
  # (Reminder: this should be a pure function that returns a new List!)
  def plus_one(l) do
    List.foldr(
      l,
      [],
      fn a, accum -> [(a + 1) | accum] end
    )
  end

  # Write a function map that generalizes modifying each element in a list while
  # maintain- ing the structure of the list. Here is its signature:
  # def map[A,B](as: List[A])(f: A => B): List[B]
  def map(l, fun) do
    List.foldr(
      l,
      [],
      fn a, accum -> [fun.(a) | accum] end
    )
  end

  # Write a function filter that removes elements from a list unless they satisfy
  # a given predicate. Use it to remove all odd numbers from a List[Int].
  # def filter[A](as: List[A])(f: A => Boolean): List[A]
  def filter(l, fun) do
    List.foldr(l, [],
      fn a, accum ->
        if fun.(a) do
          [a | accum]
        else
          accum
        end
      end
    )
  end

  # Write a function flatMap that works like map except that the function given
  # will return a list instead of a single result, and that list should be
  # inserted into the final resulting list. Here is its signature:
  # def flatMap[A,B](as: List[A])(f: A => List[B]): List[B]
  # For instance, flatMap(List(1,2,3))(i => List(i,i)) should result in
  # List(1,1,2,2,3,3).
  def flat_map(ls, fun) do
    List.foldr(ls, [],
    fn l, accum ->
      case l do
        [_ | _] -> flat_map(l, fun) ++ accum
        a -> [fun.(a) | accum]
      end
    end)
  end

  # Use flatMap to implement filter.
  # def flat_filter(l, fun) do
  #   flat_map(l, fn a ->
  #     if fun.(a) do
  #       [a]
  #     else
  #       []
  #     end
  #   end)
  # end

end

l = ["1", "2", "3", "4", "5"]
l2 = [1,2,3,4,5]
IO.puts(MyList.get_tail(l))
IO.puts(MyList.set_head(l, "6"))
IO.puts(MyList.drop(l, 2))
IO.puts(MyList.init(l))
IO.puts(MyList.product([1,2,3,4,5]))
IO.puts(MyList.product([1,0,3,4,5]))
IO.puts(MyList.length(l))
IO.puts(
  MyList.fold_left(
    l2,
    1,
    fn i, accum -> i * accum end
  )
)
IO.puts(MyList.reverse(l))
IO.puts(MyList.append(l, "6"))
IO.puts(MyList.flatten([l, l, l]))
IO.inspect(MyList.plus_one(l2))
IO.inspect(MyList.map(l2, fn a -> a + 1 end))
IO.inspect(MyList.filter(l2, fn i -> rem(i, 2) == 0 end))
IO.inspect(MyList.flat_map([l2,l2,l2], fn a -> a + 1 end))
# IO.inspect(MyList.flat_filter(l2, fn i -> rem(i, 2) == 0 end))
