defmodule Pokerwars.Ranker do
  def decide_winners(hands) do
    [Enum.max_by(hands, &calculate_numeric_score/1)]
  end

  def calculate_numeric_score(hand) do
    Pokerwars.Hand.score(hand).value
  end
end
