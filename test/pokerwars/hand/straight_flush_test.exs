defmodule Pokerwars.Hand.StraightFlushTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "straight flush" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :spades},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 5, suit: :spades}
    ]

    assert Hand.score(cards) == :straight_flush
  end

  test "straight flush scattered" do
    cards = [
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 2, suit: :hearts},
      %Card{rank: 5, suit: :hearts},
      %Card{rank: 4, suit: :hearts},
    ]

    assert Hand.score(cards) == :straight_flush
  end

  test "straight flush ace high" do
    cards = [
      %Card{rank: 1, suit: :diamonds},
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 13, suit: :diamonds},
      %Card{rank: 12, suit: :diamonds},
    ]

    assert Hand.score(cards) == :straight_flush
  end

end
