defmodule Pokerwars.Hand do
  alias Pokerwars.Card

  def score(cards) do
    evaluate(cards)
  end

  defp evaluate(_), do: :high_card
end
