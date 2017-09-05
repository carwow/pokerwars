defmodule Pokerwars.Ranker do
  alias Pokerwars.Helpers

  def decide_winners(hands) do
    Helpers.maxes_by(hands, &calculate_numeric_score/1)
  end

  def calculate_numeric_score(hand) do
    score = Pokerwars.Hand.score(hand)

    score.value +
    tie_breaking_modifier(score.tie_breaking_ranks)
  end

  defp tie_breaking_modifier(ranks) do
    _tie_breaking_modifier(ranks, 1, 0)
  end

  defp _tie_breaking_modifier([], _, result), do: result

  defp _tie_breaking_modifier([ rank | others], index, result) do
    result = result + (rank * :math.pow(100, index*-1))
    _tie_breaking_modifier(others, index+1, result)
  end
end
