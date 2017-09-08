defmodule Pokerwars.Hand do
  alias Pokerwars.Score

  def score(cards) do
    cards = Enum.sort(cards)
    calculate_score(cards)
  end

  defp calculate_score(cards) do
    [top_score | _] =
    [
      straight_flush?(cards),
      four_of_a_kind?(cards),
      flush?(cards),
      full_house?(cards),
      straight?(cards),
      three_of_a_kind?(cards),
      two_pair?(cards),
      pair?(cards),
      high_card?(cards)
    ]
    |> Enum.reject(&(&1 == nil))

    top_score
  end

  defp pair?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, k1, k2, k3] -> Score.pair(a, [k1, k2, k3])
      [k1, a, a, k2, k3] -> Score.pair(a, [k1, k2, k3])
      [k1, k2, a, a, k3] -> Score.pair(a, [k1, k2, k3])
      [k1, k2, k3, a, a] -> Score.pair(a, [k1, k2, k3])
      _ -> nil
    end
  end

  defp two_pair?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, b, b, k] -> Score.two_pair(a, b, k)
      [a, a, k, b, b] -> Score.two_pair(a, b, k)
      [k, a, a, b, b] -> Score.two_pair(a, b, k)
      _ -> nil
    end
  end

  defp three_of_a_kind?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, a, k1, k2] -> Score.three_of_a_kind(a, [k1, k2])
      [k1, a, a, a, k2] -> Score.three_of_a_kind(a, [k1, k2])
      [k1, k2, a, a, a] -> Score.three_of_a_kind(a, [k1, k2])
      _ -> nil
    end
  end

  defp four_of_a_kind?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [a, a, a, a, x] -> Score.four_of_a_kind(a, x)
      [x, a, a, a, a] -> Score.four_of_a_kind(a, x)
      _ -> nil
    end
  end

  defp flush?(cards) do
    suits = extract_suits(cards)
    kickers = extract_ranks(cards)

    case suits do
      [a, a, a, a, a] -> Score.flush(kickers)
      _ -> nil
    end
  end

  defp straight?(cards) do
    ranks = extract_ranks(cards)

    cond do
      ranks == [2, 3, 4, 5, 14] ->
        # The highest rank is 5 instead of 14 because the Ace has been used as one
        Score.straight(5)
      consecutive?(ranks) ->
        extract_highest_ranks(cards)
        |> Score.straight()
      true -> nil
    end
  end

  defp straight_flush?(cards) do
    cond do
      lower_ace_straight?(straight?(cards)) and (flush?(cards) != nil) ->
        # The highest rank is 5 instead of 14 because the Ace has been used as one
        Score.straight_flush(5)
      (straight?(cards) != nil) and (flush?(cards) != nil) ->
        extract_highest_ranks(cards)
        |> Score.straight_flush()
      true -> nil
    end
  end

  defp full_house?(cards) do
    ranks = extract_ranks(cards)
    case ranks do
      [b, b, a, a, a] -> Score.full_house(a, b)
      [a, a, a, b, b] -> Score.full_house(a, b)
      _ -> nil
    end
  end

  defp high_card?(cards) do
    kickers = extract_ranks(cards)
    Score.high_card(kickers)
  end


  defp extract_ranks(cards) do
    Enum.map(cards, fn x -> x.rank end)
  end

  defp extract_suits(cards) do
    Enum.map(cards, fn x -> x.suit end)
  end

  defp extract_highest_ranks(cards) do
    cards
    |> Enum.map(&(&1.rank))
    |> Enum.max
  end

  defp consecutive?([_a]), do: true
  defp consecutive?([a | [b | t]]) do
   a + 1 == b and consecutive?([b | t])
  end

  defp lower_ace_straight?(%{name: :straight, tie_breaking_ranks: [5], value: 5}), do: true
  defp lower_ace_straight?(_), do: false
end
