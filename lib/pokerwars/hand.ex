defmodule Pokerwars.Hand do
  alias Pokerwars.Card

  def score(cards) do
    cards
    |> Enum.sort(fn(a, b) -> a.rank > b.rank end)
    |> evaluate
  end

  defp evaluate([ %Card{rank: 14, suit: seed},
                  %Card{rank: 13, suit: seed},
                  %Card{rank: 12, suit: seed},
                  %Card{rank: 11, suit: seed},
                  %Card{rank: 10, suit: seed} ]) do
    {:royal_flush, seed}
  end

  defp evaluate([ %Card{rank: r1, suit: seed},
                  %Card{rank: r2, suit: seed},
                  %Card{rank: r3, suit: seed},
                  %Card{rank: r4, suit: seed},
                  %Card{rank: r5, suit: seed} ]) when r2 == (r1 - 1) and
                                                      r3 == (r2 - 1) and
                                                      r4 == (r3 - 1) and
                                                      r5 == (r4 - 1) do
    {:straigt_flush, seed}
  end

  defp evaluate([ %Card{suit: seed},
                  %Card{suit: seed},
                  %Card{suit: seed},
                  %Card{suit: seed},
                  %Card{suit: seed} ]) do
    {:flush, seed}
  end

  defp evaluate([ %Card{rank: r1},
                  %Card{rank: r2},
                  %Card{rank: r3},
                  %Card{rank: r4},
                  %Card{rank: r5} ]) when r2 == (r1 - 1) and
                                          r3 == (r2 - 1) and
                                          r4 == (r3 - 1) and
                                          r5 == (r4 - 1) do
    {:straigt, r1}
  end

  defp evaluate([ %Card{rank: r},
                  %Card{rank: r},
                  %Card{rank: r},
                  %Card{rank: r},
                  %Card{rank: _r1} ]) do
    {:poker, r}
  end
  defp evaluate([ %Card{rank: _r1},
                  %Card{rank: r},
                  %Card{rank: r},
                  %Card{rank: r},
                  %Card{rank: r} ]) do
    {:poker, r}
  end

  defp evaluate([ %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: r2},
                  %Card{rank: r2} ]) do
    {:full_house, [three: r1, two: r2]}
  end
  defp evaluate([ %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: r2},
                  %Card{rank: r2},
                  %Card{rank: r2} ]) do
    {:full_house, [three: r1, two: r2]}
  end

  defp evaluate([ %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: _r2},
                  %Card{rank: _r3} ]) do
    {:three_of_a_kind, r1}
  end
  defp evaluate([ %Card{rank: _r2},
                  %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: _r3} ]) do
    {:three_of_a_kind, r1}
  end
  defp evaluate([ %Card{rank: _r2},
                  %Card{rank: _r3},
                  %Card{rank: r1},
                  %Card{rank: r1},
                  %Card{rank: r1} ]) do
    {:three_of_a_kind, r1}
  end

  defp evaluate([ %Card{rank: _r1},
                  %Card{rank: _r2},
                  %Card{rank: _r3},
                  %Card{rank: rank},
                  %Card{rank: rank} ]) do
    {:pair, rank}
  end
  defp evaluate([ %Card{rank: _r1},
                  %Card{rank: _r2},
                  %Card{rank: rank},
                  %Card{rank: rank},
                  %Card{rank: _r3} ]) do
    {:pair, rank}
  end
  defp evaluate([ %Card{rank: _r1},
                  %Card{rank: rank},
                  %Card{rank: rank},
                  %Card{rank: _r2},
                  %Card{rank: _r3} ]) do
    {:pair, rank}
  end
  defp evaluate([ %Card{rank: rank},
                  %Card{rank: rank},
                  %Card{rank: _r1},
                  %Card{rank: _r2},
                  %Card{rank: _r3} ]) do
    {:pair, rank}
  end

  defp evaluate(_), do: :high_card
end
