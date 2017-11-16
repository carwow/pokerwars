defmodule Pokerwars.DeckTest do
  use ExUnit.Case, async: true
  import Pokerwars.TestHelpers

  alias Pokerwars.{Deck, Card}

  test "it creates a new deck of 52 cards" do
    result =
      Deck.in_order()
      |> Deck.size()

    assert result == 52
  end

  test "it creates a new deck in stacked order" do
    {cards, _} =
      Deck.in_order()
      |> Deck.take(5)

    result =
      cards
      |> Enum.map(&Card.print/1)
      |> Enum.join(" ")

    assert result == "2h 3h 4h 5h 6h"
  end

  test "it shuffles a deck in random order" do
    {cards, _} =
      Deck.in_order()
      |> Deck.shuffle(& &1)
      |> Deck.take(5)

    result =
      cards
      |> Enum.map(&Card.print/1)
      |> Enum.join(" ")

    assert result == "2h 3h 4h 5h 6h"
  end

  test "it deals a single card" do
    {card, new_deck} =
      Deck.in_order()
      |> Deck.deal

    assert Card.print(card) == "2h"

    {card, _} =
      Deck.deal(new_deck)

    assert Card.print(card) == "3h"
  end

  test "it creates a new deck in a specified order" do
    {cards, _} =
      Deck.from_cards(parse_cards("2h Ah 10d 7s 8h"))
      |> Deck.take(5)

    result =
      cards
      |> Enum.map(&Card.print/1)
      |> Enum.join(" ")

    assert result == "2h Ah 10d 7s 8h"
  end
end
