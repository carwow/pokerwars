defmodule Pokerwars.Hand do
  alias Pokerwars.Card

  def score(hand) do
    evaluate_hands(Permutations.of(hand))
  end

  defp evaluate_hands(hands) do
    score_hash = %{
      high_card: 1,
      pair: 2,
      three_of_a_kind: 3,
      four_of_a_kind: 4,
      straight: 5,
      flush: 6,
      straight_flush: 7,
    }
    score_value = fn x ->
      score_hash[x]
    end
    Enum.map(hands, &(evaluate_hand(&1)))
     |> Enum.max_by score_value
  end

  defp evaluate_hand([%Card{rank: 10, suit: same},
                      %Card{rank: 11, suit: same},
                      %Card{rank: 12, suit: same},
                      %Card{rank: 13, suit: same},
                      %Card{rank: 1, suit: same}
                      | _]), do: :straight_flush

  defp evaluate_hand([%Card{rank: a, suit: same},
                      %Card{rank: b, suit: same},
                      %Card{rank: c, suit: same},
                      %Card{rank: d, suit: same},
                      %Card{rank: e, suit: same}
                      | _])
                  when
                    (a == b-1) and
                    (a == c-2) and
                    (a == d-3) and
                    (a == e-4),
                  do: :straight_flush

  defp evaluate_hand([%Card{rank: _, suit: same},
                      %Card{rank: _, suit: same},
                      %Card{rank: _, suit: same},
                      %Card{rank: _, suit: same},
                      %Card{rank: _, suit: same}
                      | _]) do
     :flush
  end


  defp evaluate_hand([%Card{rank: same, suit: _},
                      %Card{rank: same, suit: _},
                      %Card{rank: same, suit: _},
                      %Card{rank: same, suit: _}
                      | _]) do
     :four_of_a_kind
  end

  defp evaluate_hand([%Card{rank: same, suit: _},
                      %Card{rank: same, suit: _},
                      %Card{rank: same, suit: _}
                      | _]) do
     :three_of_a_kind
  end

  defp evaluate_hand([%Card{rank: same, suit: _},
                      %Card{rank: same, suit: _} | _]) do
     :pair
  end

  defp evaluate_hand([%Card{rank: 10, suit: _},
                      %Card{rank: 11, suit: _},
                      %Card{rank: 12, suit: _},
                      %Card{rank: 13, suit: _},
                      %Card{rank: 1, suit: _}
                      | _]), do: :straight

  defp evaluate_hand([%Card{rank: a, suit: _},
                      %Card{rank: b, suit: _},
                      %Card{rank: c, suit: _},
                      %Card{rank: d, suit: _},
                      %Card{rank: e, suit: _}
                      | _])
                  when
                    (a == b-1) and
                    (a == c-2) and
                    (a == d-3) and
                    (a == e-4),
                  do: :straight

  defp evaluate_hand(_), do: :high_card
end
