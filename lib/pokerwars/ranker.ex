defmodule Pokerwars.Ranker do
  alias Pokerwars.Helpers

  def decide_winners(hands) do
    Helpers.maxes_by(hands, &calculate_numeric_score/1)
  end

  def calculate_numeric_score(hand) do
    score = Pokerwars.Hand.score(hand)

    score.value +
    primary_rank_modifier(score.primary_rank) +
    secondary_rank_modifier(score.secondary_rank) +
    kickers_modifier(score.kickers)
  end

  defp primary_rank_modifier(nil), do: 0

  defp primary_rank_modifier(primary_rank) do
    primary_rank * 0.01
  end

  defp secondary_rank_modifier(nil), do: 0

  defp secondary_rank_modifier(secondary_rank) do
    secondary_rank * 0.0001
  end

  defp kickers_modifier(kickers) do
    _kickers_modifier(kickers, 2, 0)
  end

  defp _kickers_modifier(nil, _, result), do: result

  defp _kickers_modifier([], _, result), do: result

  defp _kickers_modifier([ kicker | others], index, result) do
    result = result + (kicker * :math.pow(100, index*-1))
    _kickers_modifier(others, index+1, result)
  end
end
