defmodule Pokerwars.Hand.TwoPairTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates two pair at beginning" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 3, suit: :spades},
      %Card{rank: 5, suit: :hearts}
    ]

    assert Hand.score(cards) == :two_pair
  end

  test "evaluates two pair at beginning - different order" do
    cards = [
      %Card{rank: 3, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 1, suit: :diamonds},
      %Card{rank: 1, suit: :spades},
      %Card{rank: 5, suit: :hearts}
    ]

    assert Hand.score(cards) == :two_pair
  end


  test "evaluates two pair middle" do
    cards = [
      %Card{rank: 4, suit: :diamonds},
      %Card{rank: 10, suit: :spades},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 2, suit: :spades},
      %Card{rank: 4, suit: :hearts}
    ]

    assert Hand.score(cards) == :two_pair
  end

  test "evaluates pair end" do
    cards = [
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 5, suit: :spades},
      %Card{rank: 5, suit: :hearts},
      %Card{rank: 10, suit: :spades},
      %Card{rank: 10, suit: :hearts},
    ]

    assert Hand.score(cards) == :two_pair
  end

  test "evaluates pair scattered" do
    cards = [
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 7, suit: :hearts},
      %Card{rank: 3, suit: :hearts},
    ]

    assert Hand.score(cards) == :two_pair
  end
end
