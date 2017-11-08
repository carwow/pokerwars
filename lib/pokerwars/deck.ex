defmodule Pokerwars.Deck do
  alias Pokerwars.Card

  def shuffle do
    deck = for suit <- Card.suits, rank <- 1..13, do: %Card{suit: suit, rank: rank}
    Enum.shuffle(deck)
  end

  def draw([first | rest]) do
    {first, rest}
  end
end
