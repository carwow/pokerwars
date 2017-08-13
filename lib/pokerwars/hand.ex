defmodule Pokerwars.Hand do
  @moduledoc """
  Provides a set of functions that process hand of cards.

  ### Example

    iex> Pokerwars.Hand.parse("As 10s Jc Kd Qh")
    [%Pokerwars.Card{rank: 14, suit: :spades},
     %Pokerwars.Card{rank: 10, suit: :spades},
     %Pokerwars.Card{rank: 11, suit: :clubs},
     %Pokerwars.Card{rank: 13, suit: :diamonds},
     %Pokerwars.Card{rank: 12, suit: :hearts}]

    iex> hand = [%Pokerwars.Card{rank: 14, suit: :spades},
    ...> %Pokerwars.Card{rank: 10, suit: :spades},
    ...> %Pokerwars.Card{rank: 11, suit: :clubs},
    ...> %Pokerwars.Card{rank: 13, suit: :diamonds},
    ...> %Pokerwars.Card{rank: 12, suit: :hearts}]
    iex> Pokerwars.Hand.score(hand)
    :straight

  """

  def score(cards) do
    cards = Enum.sort(cards)
    calculate_score(cards)
  end

  def parse(card_strings) do
    card_strings
    |> String.split(" ")
    |> Enum.map(&(Pokerwars.Card.parse(&1)))
  end

  defp calculate_score(cards) do
    cond do
      straight_flush?(cards) -> :straight_flush
      four_of_a_kind?(cards) -> :four_of_a_kind
      flush?(cards) -> :flush
      full_house?(cards) -> :full_house
      straight?(cards) -> :straight
      three_of_a_kind?(cards) -> :three_of_a_kind
      two_pair?(cards) -> :two_pair
      pair?(cards) -> :pair
      true -> :high_card
    end
  end

  defp pair?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, _, _, _] -> true
      [_, a, a, _, _] -> true
      [_, _, a, a, _] -> true
      [_, _, _, a, a] -> true
      _ -> false
    end
  end

  defp two_pair?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, b, b, _] -> true
      [a, a, _, b, b] -> true
      [_, a, a, b, b] -> true
      _ -> false
    end
  end

  defp three_of_a_kind?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, a, _, _] -> true
      [_, a, a, a, _] -> true
      [_, _, a, a, a] -> true
      _ -> false
    end
  end

  defp four_of_a_kind?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, a, a, _] -> true
      [_, a, a, a, a] -> true
      _ -> false
    end
  end

  defp flush?(cards) do
    suits = extract_suits(cards)
    case suits do
      [a, a, a, a, a] -> true
      _ -> false
    end
  end

  defp straight?(cards) do
    ranks = extract_ranks(cards)

    ranks == [2, 3, 4, 5, 14] or
    consecutive?(ranks)
  end

  defp straight_flush?(cards) do
    straight?(cards) and
    flush?(cards)
  end

  defp full_house?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, b, b, b] -> true
      [b, b, b, a, a] -> true
      _ -> false
    end
  end

  defp extract_ranks(cards) do
    Enum.map(cards, fn x -> x.rank end)
  end

  defp extract_suits(cards) do
    Enum.map(cards, fn x -> x.suit end)
  end

  defp consecutive?([_a]), do: true
  defp consecutive?([a | [b | t]]) do
   a + 1 == b and consecutive?([b | t])
  end
end
