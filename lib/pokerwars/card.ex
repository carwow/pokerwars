defmodule Pokerwars.Card do
  # Ranks of numbered cars are represented by the number (2..10)
  # Jack, Queen, King, Ace represented by 11, 12, 13, 14 respectively

  # Suits can be: :hearts, :diamonds, :clubs, :spades

  defstruct [:rank, :suit]
end
