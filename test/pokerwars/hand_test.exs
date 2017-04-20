defmodule Pokerwars.HandTest do
  use ExUnit.Case, async: true
  alias Pokerwars.Hand
  alias Pokerwars.Card
  doctest Pokerwars.Hand

  test "evaluates royal flush of hearts" do
    cards = [
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 11, suit: :hearts},
      %Card{rank: 12, suit: :hearts},
      %Card{rank: 13, suit: :hearts},
      %Card{rank: 14, suit: :hearts}
    ]

    assert Hand.score(cards) == {:royal_flush, :hearts}
  end

  test "evaluates royal flush of spades" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 12, suit: :spades},
      %Card{rank: 13, suit: :spades},
      %Card{rank: 14, suit: :spades}
    ]

    assert Hand.score(cards) == {:royal_flush, :spades}
  end

  test "evaluates flush of spades" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: 1, suit: :spades},
      %Card{rank: 6, suit: :spades},
      %Card{rank: 3, suit: :spades},
      %Card{rank: 8, suit: :spades}
    ]

    assert Hand.score(cards) == {:flush, :spades}
  end

  test "does not evaluate royal flush for mismatching suits" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 11, suit: :diamonds},
      %Card{rank: 12, suit: :diamonds},
      %Card{rank: 13, suit: :clubs},
      %Card{rank: 14, suit: :clubs}
    ]

    assert Hand.score(cards) != {:royal_flush, nil}
  end

  test "evaluates high card" do
    cards = [
      %Card{rank: 2, suit: :spades},
      %Card{rank: 3, suit: :hearts},
      %Card{rank: 5, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 11, suit: :spades}
    ]

    assert Hand.score(cards) == :high_card
  end

  test "evaluates straigt flush of spades" do
    cards = [
      %Card{rank: 8, suit: :spades},
      %Card{rank: 9, suit: :spades},
      %Card{rank: 10, suit: :spades},
      %Card{rank: 11, suit: :spades},
      %Card{rank: 12, suit: :spades}
    ]

    assert Hand.score(cards) == {:straigt_flush, :spades}
  end

  test "evaluates straigt of spades" do
    cards = [
      %Card{rank: 8, suit: :spades},
      %Card{rank: 9, suit: :diamonds},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 11, suit: :clubs},
      %Card{rank: 12, suit: :spades}
    ]

    assert Hand.score(cards) == {:straigt, 12}
  end


  test "evaluates poker" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 10, suit: :clubs},
      %Card{rank: 4, suit: :spades}
    ]

    assert Hand.score(cards) == {:poker, 10}
  end

  test "evaluates full house" do
    cards = [
      %Card{rank: 10, suit: :spades},
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 4, suit: :clubs},
      %Card{rank: 4, suit: :spades}
    ]

    assert Hand.score(cards) == {:full_house, [three: 10, two: 4]}
  end

  test "does evaluate three of a kind" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 7, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 7, suit: :clubs},
      %Card{rank: 4, suit: :hearts}
    ]

    assert Hand.score(cards) == {:three_of_a_kind, 7}
  end

  test "does evaluate a pair" do
    cards = [
      %Card{rank: 10, suit: :diamonds},
      %Card{rank: 7, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 2, suit: :clubs},
      %Card{rank: 4, suit: :hearts}
    ]

    assert Hand.score(cards) == {:pair, 7}
  end
end
