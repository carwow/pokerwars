defmodule Pokerwars.Ranker do
  def decide_winners(hands) do
    [Enum.max_by(hands, &calculate_numeric_score/1)]
  end

  def calculate_numeric_score(hand) do
    score = Pokerwars.Hand.score(hand)
    case score do
      :straight_flush -> 9
      :four_of_a_kind -> 8
      :full_house -> 7
      :flush -> 6
      :straight -> 5
      :three_of_a_kind -> 4
      :two_pair -> 3
      :pair -> 2
      :high_card -> 1
    end
  end
end
