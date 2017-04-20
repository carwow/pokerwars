defmodule Permutations do
  def of([]) do
    [[]]
  end

  def of(list) do
    for h <- list, t <- of(list -- [h]), do: [h | t]
  end
end
