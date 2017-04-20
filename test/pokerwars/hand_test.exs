defmodule Pokerwars.HandTest do
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

  test "evaluates pair at beginning" do
    cards = [
      %Card{rank: 1, suit: :spades},
      %Card{rank: 1, suit: :hearts},
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 5, suit: :hearts}
    ]

    assert Hand.score(cards) == :pair
  end

  test "evaluates pair middle" do
    cards = [
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 10, suit: :spades},
      %Card{rank: 10, suit: :hearts},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 5, suit: :hearts}
    ]

    assert Hand.score(cards) == :pair
  end

  test "evaluates pair end" do
    cards = [
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 5, suit: :hearts},
      %Card{rank: 10, suit: :spades},
      %Card{rank: 10, suit: :hearts},
    ]

    assert Hand.score(cards) == :pair
  end

  test "evaluates pair scattered" do
    cards = [
      %Card{rank: 3, suit: :diamonds},
      %Card{rank: 7, suit: :spades},
      %Card{rank: 4, suit: :spades},
      %Card{rank: 7, suit: :hearts},
      %Card{rank: 5, suit: :hearts},
    ]

    assert Hand.score(cards) == :pair
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
end
