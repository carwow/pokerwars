defmodule Pokerwars.HandTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates royal flush of hearts" do
    cards = [
      %Card{rank: 10, suit: :hearts},
      %Card{rank: :jack, suit: :hearts},
      %Card{rank: :queen, suit: :hearts},
      %Card{rank: :king, suit: :hearts},
      %Card{rank: :ace, suit: :hearts}
    ]

    assert Hand.score(cards) == :royal_flush
  end

  test "evaluates royal flush of spades" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: :jack, suit: :spades},
      %Card{rank: :queen, suit: :spades},
      %Card{rank: :king, suit: :spades},
      %Card{rank: :ace, suit: :spades}
    ]

    assert Hand.score(cards) == :royal_flush
  end

  test "does not evaluate royal flush for mismatching suits" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: :jack, suit: :diamonds},
      %Card{rank: :queen, suit: :diamonds},
      %Card{rank: :king, suit: :clubs},
      %Card{rank: :ace, suit: :clubs}
    ]

    assert Hand.score(cards) != :royal_flush
  end

  test "evaluates straight flush" do
    cards = [
      %Card{rank: 3, suit: :clubs},
      %Card{rank: 4, suit: :clubs},
      %Card{rank: 5, suit: :clubs},
      %Card{rank: 6, suit: :clubs},
      %Card{rank: 7, suit: :clubs}
    ]

    assert Hand.score(cards) == :straight_flush
  end

  test "evaluates straight flush starting from ace" do
    cards = [
      %Card{rank: :ace, suit: :clubs},
      %Card{rank: 2, suit: :clubs},
      %Card{rank: 3, suit: :clubs},
      %Card{rank: 4, suit: :clubs},
      %Card{rank: 5, suit: :clubs}
    ]

    assert Hand.score(cards) == :straight_flush
  end

  test "evaluates high card" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: :jack, suit: :spades}
    ]

    assert Hand.score(cards) == :high_card
  end
end
