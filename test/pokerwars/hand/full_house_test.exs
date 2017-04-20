defmodule Pokerwars.Hand.FullHouseTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates full house - case 1" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 1, suit: :clubs},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 3, suit: :spades}
    ]

    assert Hand.score(cards) == :full_house
  end

  test "evaluates full house - case 2" do
    cards = [
      %Card{rank: 3, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 3, suit: :clubs},
      %Card{rank: 1, suit: :diamonds},
      %Card{rank: 1, suit: :spades}
    ]

    assert Hand.score(cards) == :full_house
  end

  test "evaluates full house - scattered" do
    cards = [
      %Card{rank: 3, suit: :spades},
      %Card{rank: 1, suit: :diamonds},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 1, suit: :spades},
      %Card{rank: 3, suit: :clubs}
    ]

    assert Hand.score(cards) == :full_house
  end
end
