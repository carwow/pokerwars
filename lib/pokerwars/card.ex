defmodule Pokerwars.Card do
  # Ranks can be: 2..10 | :jack | :queen | :king | :ace
  # Suits can be: :hearts | :diamonds | :clubs | :spades

  defstruct [:rank, :suit]
end
