defmodule Pokerwars.Hand.FourOfAKind do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates four of a kind at beginning" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 1, suit: :clubs},
      %Card{rank: 1, suit: :diamonds},
      %Card{rank: 4, suit: :spades},
    ]

    assert Hand.score(cards) == :four_of_a_kind
  end

  test "evaluates four of a kind at end" do
    cards = [
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 5, suit: :spades},
      %Card{rank: 5, suit: :hearts},
      %Card{rank: 5, suit: :clubs}
    ]

    assert Hand.score(cards) == :four_of_a_kind
  end

  test "evaluates four of a kind scattered" do
    cards = [
      %Card{rank: 7, suit: :hearts},
      %Card{rank: 7, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 7, suit: :clubs}
    ]

    assert Hand.score(cards) == :four_of_a_kind
  end

end
