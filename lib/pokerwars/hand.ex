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
    }
    score_value = fn x ->
      score_hash[x]
    end
    Enum.map(hands, &(evaluate_hand(&1)))
     |> Enum.max_by score_value
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

  defp evaluate_hand(_) do
    :high_card
  end

end
