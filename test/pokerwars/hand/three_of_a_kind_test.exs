defmodule Pokerwars.Hand.ThreeOfAKind do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates three of a kind at beginning" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 1, suit: :clubs},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 4, suit: :spades},
    ]

    assert Hand.score(cards) == :three_of_a_kind
  end

  test "evaluates three of a kind at end" do
    cards = [
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 1, suit: :spades},
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 1, suit: :clubs}
    ]

    assert Hand.score(cards) == :three_of_a_kind
  end

  test "evaluates three of a kind scattered" do
    cards = [
      %Card{rank: 7, suit: :hearts},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 7, suit: :clubs}
    ]

    assert Hand.score(cards) == :three_of_a_kind
  end
end
