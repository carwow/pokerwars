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
  def stronger_hand(a, a), do: a
  def stronger_hand(left_hand, right_hand) do
    do_stronger_hand(
      {left_hand, Hand.score(left_hand)},
      {right_hand, Hand.score(right_hand)}
    )
  end

  defp do_stronger_hand({left_hand, left_hand_type}, {right_hand, right_hand_type}) do
    cond do
      @hands_scores[left_hand_type] > @hands_scores[right_hand_type] ->
        left_hand
      @hands_scores[left_hand_type] < @hands_scores[right_hand_type] ->
        right_hand
      true ->
        stronger_rank_hand(Enum.sort(left_hand), Enum.sort(right_hand), left_hand_type)
    end
  end

  # straight and straight flush cases with Ace
  defp stronger_rank_hand([%{rank: 2}, _, _, _, %{rank: 14}], [%{rank: 2}, _, _, _, %{rank: 14}], type) when type in [:straight, :straight_flush], do: :split_pot
  defp stronger_rank_hand([%{rank: 2}, _, _, _, %{rank: 14}], hand, type) when type in [:straight, :straight_flush], do: hand
  defp stronger_rank_hand(hand, [%{rank: 2}, _, _, _, %{rank: 14}], type) when type in [:straight, :straight_flush], do: hand

  defp stronger_rank_hand(left_hand, right_hand, hand_type) when hand_type in [:high_card, :straight, :flush, :straight_flush] do
    left_sorted_ranks = left_hand |> Enum.map(&(&1.rank)) |> Enum.sort(&(&1 >= &2))
    right_sorted_ranks = right_hand |> Enum.map(&(&1.rank)) |> Enum.sort(&(&1 >= &2))

    case compare_ordered_ranks(left_sorted_ranks, right_sorted_ranks) do
      1 -> left_hand
      -1 -> right_hand
      _ -> :split_pot
    end
  end
  defp stronger_rank_hand(left_hand, right_hand, :pair), do: do_stronger_rank_hand(left_hand, right_hand, :high_card)
  defp stronger_rank_hand(left_hand, right_hand, :two_pair), do: do_stronger_rank_hand(left_hand, right_hand, :pair)
  defp stronger_rank_hand(left_hand, right_hand, :three_of_a_kind), do: do_stronger_rank_hand(left_hand, right_hand, :high_card)
  defp stronger_rank_hand(left_hand, right_hand, :full_house), do: do_stronger_rank_hand(left_hand, right_hand, :pair)
  defp stronger_rank_hand(left_hand, right_hand, :four_of_a_kind), do: do_stronger_rank_hand(left_hand, right_hand, :high_card)

  defp do_stronger_rank_hand(left_hand, right_hand, hand_type_for_recursion) do
    left_pair_card = extract_highest_same(left_hand)
    right_pair_card = extract_highest_same(right_hand)

    cond do
      left_pair_card.rank > right_pair_card.rank -> left_hand
      left_pair_card.rank < right_pair_card.rank -> right_hand
      true ->
        # exclude n-of-a-kind card and continue with the rest
        reduced_left_hand = left_hand |> Enum.filter(&(left_pair_card.rank != &1.rank))
        reduced_right_hand = right_hand |> Enum.filter(&(right_pair_card.rank != &1.rank))

        case stronger_rank_hand(reduced_left_hand, reduced_right_hand, hand_type_for_recursion) do
          ^reduced_left_hand -> left_hand
          ^reduced_right_hand -> right_hand
          _ -> :split_pot
        end
    end
  end

  defp extract_highest_same(hand) do
    [{max_card, max_frequence} | hand_tail] =
      hand
      |> Enum.group_by(&(&1.rank))
      |> Enum.map(fn {rank, cards} -> {hd(cards), length(cards)} end)
      |> Enum.sort_by(fn {card, repetitions} -> -repetitions end)

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
end
