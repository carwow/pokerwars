defmodule Pokerwars.Hand.FlushTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "flush spades" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 2, suit: :spades},
      %Card{rank: 8, suit: :spades},
      %Card{rank: 9, suit: :spades},
      %Card{rank: 4, suit: :spades}
    ]

    assert Hand.score(cards) == :flush
  end

  test "flush hearts" do
    cards = [
      %Card{rank: 8, suit: :hearts},
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 9, suit: :hearts},
      %Card{rank: 4, suit: :hearts}
    ]

    assert Hand.score(cards) == :flush
  end

end
