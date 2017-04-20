defmodule Pokerwars.Hand.StraightTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "straight" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 2, suit: :clubs},
      %Card{rank: 3, suit: :spades},
      %Card{rank: 4, suit: :hearts},
      %Card{rank: 5, suit: :diamonds}
    ]

    assert Hand.score(cards) == :straight
  end

  test "straight scattered" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 3, suit: :spades},
      %Card{rank: 2, suit: :clubs},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 4, suit: :hearts},
    ]

    assert Hand.score(cards) == :straight
  end

  test "straight ace high" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 10, suit: :spades},
      %Card{rank: 11, suit: :clubs},
      %Card{rank: 13, suit: :diamonds},
      %Card{rank: 12, suit: :hearts},
    ]

    assert Hand.score(cards) == :straight
  end
end
