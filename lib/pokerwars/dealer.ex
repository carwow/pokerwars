defmodule Pokerwars.Dealer do
  @moduledoc """
  Provides a set of functions for comparing poker hands.

  ### Example

    iex> three_of_a_hand = [%Pokerwars.Card{rank: 3, suit: :diamonds},
    ...> %Pokerwars.Card{rank: 4, suit: :spades},
    ...> %Pokerwars.Card{rank: 14, suit: :spades},
    ...> %Pokerwars.Card{rank: 14, suit: :hearts},
    ...> %Pokerwars.Card{rank: 14, suit: :clubs}]
    iex> straight = [%Pokerwars.Card{rank: 14, suit: :spades},
    ...> %Pokerwars.Card{rank: 3, suit: :spades},
    ...> %Pokerwars.Card{rank: 2, suit: :clubs},
    ...> %Pokerwars.Card{rank: 5, suit: :diamonds},
    ...> %Pokerwars.Card{rank: 4, suit: :hearts}]
    iex> Dealer.stronger_hand(straight, three_of_a_hand)
    [%Pokerwars.Card{rank: 14, suit: :spades},
     %Pokerwars.Card{rank: 3, suit: :spades},
     %Pokerwars.Card{rank: 2, suit: :clubs},
     %Pokerwars.Card{rank: 5, suit: :diamonds},
     %Pokerwars.Card{rank: 4, suit: :hearts}]

  """

  alias Pokerwars.Hand

  @hands_scores %{
    straight_flush: 9,
    four_of_a_kind: 8,
    full_house: 7,
    flush: 6,
    straight: 5,
    three_of_a_kind: 4,
    two_pair: 3,
    pair: 2,
    high_card: 1
  }

  @doc """
  Returns the stronger hand.
  """
  def stronger_hand(hand, hand), do: hand
  def stronger_hand(left_hand, right_hand) do
    left_hand_type = Hand.score(left_hand)
    right_hand_type = Hand.score(right_hand)

    cond do
      @hands_scores[left_hand_type] > @hands_scores[right_hand_type] ->
        left_hand
      @hands_scores[left_hand_type] < @hands_scores[right_hand_type] ->
        right_hand
      true ->
        do_stronger_hand(left_hand, right_hand, left_hand_type)
    end
  end

  defp do_stronger_hand(left_hand, right_hand, hand_type) do
    case compare_same_hands(sort_by_rank(left_hand), sort_by_rank(right_hand), hand_type) do
      1 -> left_hand
      -1 -> right_hand
      _ -> :split_pot
    end
  end

  # straight and straight flush cases with Ace
  defp compare_same_hands([%{rank: 14}, _, _, _, %{rank: 2}], [%{rank: 14}, _, _, _, %{rank: 2}], type) when type in [:straight, :straight_flush], do: 0
  defp compare_same_hands([%{rank: 14}, _, _, _, %{rank: 2}], _hand, type) when type in [:straight, :straight_flush], do: -1
  defp compare_same_hands(_hand, [%{rank: 14}, _, _, _, %{rank: 2}], type) when type in [:straight, :straight_flush], do: 1

  defp compare_same_hands(left_hand, right_hand, hand_type) when hand_type in [:high_card, :straight, :flush, :straight_flush] do
    left_sorted_ranks = Enum.map(left_hand, &(&1.rank))
    right_sorted_ranks = Enum.map(right_hand, &(&1.rank))
    compare_ordered_ranks(left_sorted_ranks, right_sorted_ranks)
  end
  defp compare_same_hands(left_hand, right_hand, :pair), do: do_compare_same_hands(left_hand, right_hand, :high_card)
  defp compare_same_hands(left_hand, right_hand, :two_pair), do: do_compare_same_hands(left_hand, right_hand, :pair)
  defp compare_same_hands(left_hand, right_hand, :three_of_a_kind), do: do_compare_same_hands(left_hand, right_hand, :high_card)
  defp compare_same_hands(left_hand, right_hand, :full_house), do: do_compare_same_hands(left_hand, right_hand, :pair)
  defp compare_same_hands(left_hand, right_hand, :four_of_a_kind), do: do_compare_same_hands(left_hand, right_hand, :high_card)

  defp do_compare_same_hands(left_hand, right_hand, hand_type) do
    left_pair_card = find_highest_of_a_kind(left_hand)
    right_pair_card = find_highest_of_a_kind(right_hand)

    cond do
      left_pair_card.rank > right_pair_card.rank -> 1
      left_pair_card.rank < right_pair_card.rank -> -1
      true -> # exclude n-of-a-kind card and continue with the rest
        reduced_left_hand = left_hand |> Enum.filter(&(left_pair_card.rank != &1.rank))
        reduced_right_hand = right_hand |> Enum.filter(&(right_pair_card.rank != &1.rank))
        compare_same_hands(reduced_left_hand, reduced_right_hand, hand_type)
    end
  end

  defp find_highest_of_a_kind(hand) do
    [{max_card, max_frequence} | hand_tail] =
      hand
      |> Enum.group_by(&(&1.rank))
      |> Enum.map(fn {_rank, cards} -> {hd(cards), length(cards)} end)
      |> Enum.sort_by(fn {_card, repetitions} -> -repetitions end)

    # this step is needed for the case of two pairs
    {possible_max_card, possible_max_frequence} = Enum.at(hand_tail, 0, {nil, 0}) # defaults to {nil, 0} when hand_tail empty
    cond do
      max_frequence == possible_max_frequence ->
        if possible_max_card.rank > max_card.rank, do: possible_max_card, else: max_card
      true -> max_card
    end
  end

  defp compare_ordered_ranks([], []), do: 0
  defp compare_ordered_ranks([left_kicker | _], [right_kicker | _]) when left_kicker > right_kicker, do: 1
  defp compare_ordered_ranks([left_kicker | _], [right_kicker | _]) when left_kicker < right_kicker, do: -1
  defp compare_ordered_ranks([_ | left_ranks_tail], [_ | right_ranks_tail]) do
    compare_ordered_ranks(left_ranks_tail, right_ranks_tail)
  end

  defp sort_by_rank(hand), do: Enum.sort(hand, &(&1.rank >= &2.rank))
end
